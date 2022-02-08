Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECBD4AD7EF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiBHLwe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 06:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbiBHLwe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 06:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0A7BC03FEC0
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644321151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MKu7WQEn9DpcC0w+ZVuJvCaE5jPe72ovb7SuWms1iY=;
        b=EhFrvo56JPx9nsugxBpBeZVy47H7GbBLJD4YJpLYeolI+ZBc3sxWfBMMDvtuGucLpYWHo3
        FXXcWktwKxk1tcQUKtQEatdXB745wSj3xcIBjOmqCXWaUTpVKavBY/ka345oNG7BS6hV78
        5hlhBM+ATsRW73NvQNQp2jl0C9sr0ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-DRjM5o7XMwuXsEDKSsAjrQ-1; Tue, 08 Feb 2022 06:52:30 -0500
X-MC-Unique: DRjM5o7XMwuXsEDKSsAjrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B521A8145E3;
        Tue,  8 Feb 2022 11:52:29 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 741AF2B3CA;
        Tue,  8 Feb 2022 11:52:29 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Tue, 08 Feb 2022 06:52:28 -0500
Message-ID: <A677D8A9-FD0B-43E5-82D6-E660CCB8B185@redhat.com>
In-Reply-To: <164428557862.27779.17375354328525752842@noble.neil.brown.name>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <164428557862.27779.17375354328525752842@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Feb 2022, at 20:59, NeilBrown wrote:

> On Sun, 06 Feb 2022, Benjamin Coddington wrote:
>> Hi all,
>>
>> Is anyone using a udev(-like) implementation with NETLINK_LISTEN_ALL_NSID?
>> It looks like that is at least necessary to allow the init namespaced udev
>> to receive notifications on /sys/fs/nfs/net/nfs_client/identifier, which
>> would be a pre-req to automatically uniquify in containers.
>
> Could you walk me through the reasoning here - or point me to where it
> has been discussed.

https://lore.kernel.org/linux-nfs/20210414181040.7108-1-steved@redhat.com/

> It seems to me that mount.nfs is the place to set nfs_client/identifier.
> It can be told (via /etc/nfs.conf or /etc/nfsmount.conf) how to generate
> and where to store the identifier.  It can check the current value and
> update if needed.  As long as the identifier is set before the first
> mount, there is no rush.
>
> Why does it need to be done in response to a uevent??

I think the assertion was that it was the only sensible way, and it does
seem to be better than exposing yet another knob when all that's needed is a
way to distinguish and persist NFS clients when network namespaces can come
and go at any time, and there can be a lot of them.

Ben

