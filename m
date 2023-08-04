Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0019577042D
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHDPQz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHDPQz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 11:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8F46B2
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691162168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TFGCVBixHWoddaHUZlj3GwOKpQe3T9GklOi5J5GPXO8=;
        b=jOuRqcfrfRadZx20NZpQFfjCY1CXPYInMtvTVlqzwxvZEfhk/qqfqn29TuharFpglUv3ya
        2dcOrzDRChNmm3xWi1u5hJ8QVQSFX65sRGh6/mXJlnQ2piRbmgoKgozc3WZ+sJF/UlDR/m
        oQ4UZWUYPj6uYP+SjoJPxk6thR53eY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-auNe4SOsMHqkrhZQkeDG0w-1; Fri, 04 Aug 2023 11:16:05 -0400
X-MC-Unique: auNe4SOsMHqkrhZQkeDG0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97722104458B;
        Fri,  4 Aug 2023 15:16:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08CACC5796B;
        Fri,  4 Aug 2023 15:16:03 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix race to FREE_STATEID and cl_revoked
Date:   Fri, 04 Aug 2023 11:16:02 -0400
Message-ID: <FE888F7B-80EC-4BF9-AA45-BAF5E28513C2@redhat.com>
In-Reply-To: <ZM0TF/rOFOxlaA+p@tissot.1015granger.net>
References: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
 <ZM0TF/rOFOxlaA+p@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Aug 2023, at 11:02, Chuck Lever wrote:

> On Fri, Aug 04, 2023 at 10:52:20AM -0400, Benjamin Coddington wrote:
>> We have some reports of linux NFS clients that cannot satisfy a linux knfsd
>> server that always sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED even though
>> those clients repeatedly walk all their known state using TEST_STATEID and
>> receive NFS4_OK for all.
>>
>> Its possible for revoke_delegation() to set NFS4_REVOKED_DELEG_STID, then
>> nfsd4_free_stateid() finds the delegation and returns NFS4_OK to
>> FREE_STATEID.  Afterward, revoke_delegation() moves the same delegation to
>> cl_revoked.  This would produce the observed client/server effect.
>>
>> Fix this by ensuring that the setting of sc_type to NFS4_REVOKED_DELEG_STID
>> and move to cl_revoked happens within the same cl_lock.  This will allow
>> nfsd4_free_stateid() to properly remove the delegation from cl_revoked.
>>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2217103
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2176575
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>
> Hi Ben, does this fix deserve:
>
> Cc: stable@vger.kernel.org # v4.17+

Yes, that's probably appropriate.

Ben

