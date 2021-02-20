Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C558320731
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 22:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBTVTH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Feb 2021 16:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhBTVTF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Feb 2021 16:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613855859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Vk8BAIJ1uIAxCVSQYpQIIdAE9knnRSPLsjNrtwjnAk=;
        b=MsyHrnmriBwkwQ5whBZkHkd8CX+GruDYBR8Lji+padpGM9jo/2DrSWr/COo5UAP7naD/l+
        LLvnPM/mGiDvDU/wHlLCFZ8fOyTfspHKT6jWFcWOp0r4H6s0sjf89UXIkU41SlJzzFG/et
        d4D3iguHSLfIQeGxvNrNpoxl9kLOSMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-qZ_pHs6nOu-iOfvAWM_Hag-1; Sat, 20 Feb 2021 16:17:35 -0500
X-MC-Unique: qZ_pHs6nOu-iOfvAWM_Hag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B650518449E4;
        Sat, 20 Feb 2021 21:17:34 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 716FB5D9C6;
        Sat, 20 Feb 2021 21:17:34 +0000 (UTC)
From:   Steve Dickson <SteveD@RedHat.com>
Subject: ANNOUNCE: nfs-utils-2.5.3 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <7f306bd8-d181-3536-8c3b-eb43f566aaf7@RedHat.com>
Date:   Sat, 20 Feb 2021 16:19:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

There is a new daemon call nfsv4.exportd that will only
listen for NFSv4 mounts which will allow for a NFSv4
only server, which should make things a bit more 
container friendly. Note, the --enable-nfsv4server
is needed for the code to be included in the compilation.

NeilBrown did a lot of work in converting the
config parsing code to used the came code as
the mount.nfs used. Thanks you!

As well as a number of bug fixes... 

The tarballs can be found in
  https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.3/
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.3

The change log is in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.3/2.5.3-Changelog
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.3/

The git tree is at:
   git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

