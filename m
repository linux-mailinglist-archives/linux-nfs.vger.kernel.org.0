Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14513796D2
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhEJSK4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 14:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230357AbhEJSK4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 May 2021 14:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620670191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zRwqyWwFJLYt0S97oMNqz2gP8lJOZ9ARTCbccwl6xWM=;
        b=B4863HmNKEoVepfW8tqZ6dnG6qeCzj2qqMVZQRnocRv/jQWzXQ7vHwXQudGAMKJ+Yr7UMk
        0p5+eCVsSVsbIzl0lnEpncDjqEixjKz3AoWctd/4z6maYVhU1yndBKrx49BAbKeYD3wjDO
        QaQbFNR1Vlf743tLEgSA9t4MaQcqV2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-Aa-EJcn_Ns6iRJa51g7uJg-1; Mon, 10 May 2021 14:09:49 -0400
X-MC-Unique: Aa-EJcn_Ns6iRJa51g7uJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD589126B;
        Mon, 10 May 2021 18:09:48 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-61.phx2.redhat.com [10.3.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D33C55DEC1;
        Mon, 10 May 2021 18:09:47 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: libtirpc-1.3.2 released.
To:     libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <d942a6c1-0b90-0076-46b8-a5dc6baab1f7@RedHat.com>
Date:   Mon, 10 May 2021 14:12:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

This is a minor release... a few ports added to the blacklist,
and a couple bug fixes. 

The tarball:
   http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.2/libtirpc-1.3.2.tar.bz2

Release notes:
    http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.2/Release-1.3.2.txt

The git tree is at:
   git://linux-nfs.org/~steved/libtirpc


steved.

