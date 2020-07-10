Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83FD21BB22
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGJQhf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 12:37:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23838 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727782AbgGJQhf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 12:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594399054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m5ZRGeiBQUS2i7oljZ3/tt1LJdxHb71UQ5Fi1rsQzqo=;
        b=Tbyb9P3CDxOjiU+/wnP4K41COPbuAUaqvzrKP4RO4i9PDLO+rlL48nx59+1o1iKQwPfndJ
        2qXUkKWScqP+vVhBOet8aVNarJk81J2AamB5jKKONfyEoHM5p4GtRlMWn2zkfVKFzQBMOq
        Q/CtbsSPt4tPmfU6N8SuWSd1L1i00h0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-LkB42OOyPjaZoyJJTUhv_w-1; Fri, 10 Jul 2020 12:37:32 -0400
X-MC-Unique: LkB42OOyPjaZoyJJTUhv_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A387F800D5C
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 16:37:30 +0000 (UTC)
Received: from ovpn-112-86.ams2.redhat.com (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F4317D82;
        Fri, 10 Jul 2020 16:37:29 +0000 (UTC)
Message-ID: <5a84777afb9ed8c866841471a1a7e3c9b295604d.camel@redhat.com>
Subject: [PATCH 0/4] nfs-utils: nfs.conf features to enable use of
 machine-id as nfs4_unique_id
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 10 Jul 2020 17:37:27 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch set introduces some additional features to the nfs.conf tool
chain that allows automatic use of /etc/machine-id or other unique
values for setups that otherwise do not have a unique hostname or disk
image and would thus otherwise generate non-unique EXCHANGE_ID and
SETCLIENTID messages. 

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>

