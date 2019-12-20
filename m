Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43EB128053
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2019 17:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfLTQEw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Dec 2019 11:04:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55825 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727233AbfLTQEw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Dec 2019 11:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576857891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jFiyByl/4oASeVA4xuLLVhEkXiuUSoaVLBXAuPLsDAw=;
        b=ZjnvQcGQq//O1reS6DMplxvTXJZj334ww5CW3HiWrjnqh7aZElx8YeunTWIBzHNzjYFTqi
        7sFnKXIm1Q8nLMLajiv7krcRx+TOhVQQm8StwOoZXiQQuiw8o20QVovXSqcLNMN5VsSgv6
        HGtXKLsQOXRydLhBTm214EVFKjxT3cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-sEUeXhkEMq2a0DPZlvq6gA-1; Fri, 20 Dec 2019 11:04:50 -0500
X-MC-Unique: sEUeXhkEMq2a0DPZlvq6gA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19DB78FD564;
        Fri, 20 Dec 2019 16:04:49 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-81.phx2.redhat.com [10.3.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C60065DA2C;
        Fri, 20 Dec 2019 16:04:48 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: libtirpc-1.2.5 released.
To:     libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <e5b97cfa-96a0-7200-5ac2-64af20f88100@RedHat.com>
Date:   Fri, 20 Dec 2019 11:04:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

The 1.2.5 version of libtirpc has just been release.

A number resource leaks and other issues were fix
which were identified by a Coverity Scan. 

The AUTH_DES authentication has been deprecated.
If any of those routines are called, they will 
fail immediately. 

Plus, numerous bug fixes 

The tarball:
   http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.4/libtirpc-1.2.5.tar.bz2

Release notes:
    http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.4/Release-1.2.5.txt

The git tree is at:
   git://linux-nfs.org/~steved/libtirpc


steved.

