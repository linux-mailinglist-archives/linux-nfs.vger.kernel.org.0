Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7A7704E1
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHDPgA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHDPf7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 11:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EAC49D4
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691163316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExzJzCWYSFK5ETJBSbY+7zclrps++XRInh5NBUCythU=;
        b=RzEM09zv7/otbRXaSyFojDA57MsUc1i6Lc2B9FWBWeNiz6UporfRXSensDXW6iZS/T1rSg
        oXgvHLKwaxOY1z+0MklaMTahvaXYksRFWN+VyfGg+XI6iPHgts5N3i/ddK3/xtciYvixGZ
        DKC65ztyHeEEQ5jGtc9nAQarm2mdUP0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-UTQ5Vb-ANSOPsPGTHvWDCQ-1; Fri, 04 Aug 2023 11:35:14 -0400
X-MC-Unique: UTQ5Vb-ANSOPsPGTHvWDCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6847A29AB400;
        Fri,  4 Aug 2023 15:35:14 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0585F7FB8;
        Fri,  4 Aug 2023 15:35:13 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix race to FREE_STATEID and cl_revoked
Date:   Fri, 04 Aug 2023 11:35:12 -0400
Message-ID: <2F29BA80-0545-4AD3-8C18-109AA32CC144@redhat.com>
In-Reply-To: <7e6053d48b2e4d62c7875e76653ecbc7557ec8d4.camel@kernel.org>
References: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
 <ZM0TF/rOFOxlaA+p@tissot.1015granger.net>
 <7e6053d48b2e4d62c7875e76653ecbc7557ec8d4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Aug 2023, at 11:33, Jeff Layton wrote:

> On Fri, 2023-08-04 at 11:02 -0400, Chuck Lever wrote:
>> On Fri, Aug 04, 2023 at 10:52:20AM -0400, Benjamin Coddington wrote:
>>> We have some reports of linux NFS clients that cannot satisfy a linux knfsd
>>> server that always sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED even though
>>> those clients repeatedly walk all their known state using TEST_STATEID and
>>> receive NFS4_OK for all.
>>>
>>> Its possible for revoke_delegation() to set NFS4_REVOKED_DELEG_STID, then
>>> nfsd4_free_stateid() finds the delegation and returns NFS4_OK to
>>> FREE_STATEID.  Afterward, revoke_delegation() moves the same delegation to
>>> cl_revoked.  This would produce the observed client/server effect.
>>>
>>> Fix this by ensuring that the setting of sc_type to NFS4_REVOKED_DELEG_STID
>>> and move to cl_revoked happens within the same cl_lock.  This will allow
>>> nfsd4_free_stateid() to properly remove the delegation from cl_revoked.
>>>
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2217103
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2176575
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>
>> Hi Ben, does this fix deserve:
>>
>> Cc: stable@vger.kernel.org # v4.17+
>>
>> ??
>>
>
> What's special about v4.17? Is there a patch that broke it that went
> into that release?

Before 0af6e690f0d4e the patch won't apply.

Ben

