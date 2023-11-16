Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854DE7EE919
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 23:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjKPWDZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 17:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKPWDZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 17:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683211F
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700172201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7UfAnV3IuDndYV+jqUQE0EGqKybl/FrxVESHQ0cDEo=;
        b=NNWmCZmrtb0gSx6As6dkdVgeaHaXT1odYA6G3/Va8mCcBxN3i8aYpMYnzdk8J52BjUBoCr
        OgnK5hTShUL2vuA/IC7BpWXSNdDT76Fd3STvTPwgz6vWhiGNXiuGd8SJoHeg5IgDPYa2mw
        Ex11QZCGGiyKKOKsyR28vNuxSEke098=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-vtybo1P7NOmIv5dcNjbqIA-1; Thu,
 16 Nov 2023 17:03:20 -0500
X-MC-Unique: vtybo1P7NOmIv5dcNjbqIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C503F1C0519B;
        Thu, 16 Nov 2023 22:03:19 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F782C157E5;
        Thu, 16 Nov 2023 22:03:19 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: drop unused nfs_direct_req bytes_left
Date:   Thu, 16 Nov 2023 17:03:17 -0500
Message-ID: <CCFAA747-7BC9-40AB-8E37-A18B33A01511@redhat.com>
In-Reply-To: <CAFX2Jfkc7p+22aK0KvN4yUerS1HuKDC+Njo_AJV1=5pWW0sUYQ@mail.gmail.com>
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700083991.git.bcodding@redhat.com>
 <952eea7e97246870f83e7a4592e9338007dfe625.1700083991.git.bcodding@redhat.com>
 <CAFX2Jfkc7p+22aK0KvN4yUerS1HuKDC+Njo_AJV1=5pWW0sUYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2023, at 16:44, Anna Schumaker wrote:

> Hi Ben,
>
> On Wed, Nov 15, 2023 at 4:34 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> Now that we're calculating how large a remaining IO should be based
>> on the current request's offset, we no longer need to track bytes_left on
>> each struct nfs_direct_req.  Drop the field, and clean up the direct
>> request tracepoints.
>
> I've been having problems with xfstests generic/465 on all NFS
> versions after applying this patch. Looking at wireshark, the client
> appears to be resending the same reads over and over again. Have you
> seen anything like this in your testing?

I have generic/465 failing before and after these two patches on pNFS SCSI..
but at least it completes.  If I run it without pNFS I can see the same
thing.. it just sends the same reads over and over.  I'll figure out why.

Ben

