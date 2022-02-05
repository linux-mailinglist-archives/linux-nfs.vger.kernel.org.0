Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2224AA992
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Feb 2022 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiBEPDw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Feb 2022 10:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234584AbiBEPDv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Feb 2022 10:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644073431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=zG+MeACT7S9S+8pDDBhuv6OdJ/BZ03f47XeG4yAzxlQ=;
        b=fHPkLDnasY3KZf1Q0kSaoeWjB0omQJnpviTaC5qad5SXjRBvlgnU52d2g7p18taTrXA28D
        F0XNdz+GRtHvsBUXlKjk4DTujxse4qKfBfWlAiioJw35cFkmLuLVLkv1/7N/HjUbcWpBpL
        4NJmgh//D7Qf8oAiuyySop3wKRhrhBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-cSY3FgVXMGa7PHC-qNSzpQ-1; Sat, 05 Feb 2022 10:03:49 -0500
X-MC-Unique: cSY3FgVXMGa7PHC-qNSzpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBB7F1006AA0
        for <linux-nfs@vger.kernel.org>; Sat,  5 Feb 2022 15:03:48 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88BDC2B3C9
        for <linux-nfs@vger.kernel.org>; Sat,  5 Feb 2022 15:03:48 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: v4 clientid uniquifiers in containers/namespaces
Date:   Sat, 05 Feb 2022 10:03:46 -0500
Message-ID: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Is anyone using a udev(-like) implementation with NETLINK_LISTEN_ALL_NSID?
It looks like that is at least necessary to allow the init namespaced udev
to receive notifications on /sys/fs/nfs/net/nfs_client/identifier, which
would be a pre-req to automatically uniquify in containers.

I'md interested since it will inform whether I need to send patches to
systemd's udev, and potentially open the can of worms over there.  Yet its
not yet clear to me how an init namespaced udev process can write to a netns
sysfs path.

Another option might be to create yet another daemon/tool that would listen
specifically for these notifications.  Ugh.

Ben

