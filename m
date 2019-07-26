Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF4764C2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2019 13:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGZLpj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jul 2019 07:45:39 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37917 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGZLpi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jul 2019 07:45:38 -0400
Received: by mail-wr1-f49.google.com with SMTP id g17so54128480wrr.5
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2019 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=mXZwP2hoczQfrlEydy4jWIW1BdPXbgXaZJRNxyejTsM=;
        b=g7Nw+TGty8O/WErj9cNBvRfYP4N04uwg/M9q4Ju6bXSbLvvZqF9h412XA170Ottd32
         xLLeoBwP1usY+Cg8Q8Yf4lVyQt8IBURnxKOAv3vWwYq64fxXeJZRNiiefywC7FhP5Bx7
         WK6MhKxBafYL8CHTaROkv87/U9nNGMfu6E9B4fcN5gUH9j2SHrR0SvptvIc6AhMyYxv8
         SXP7QtMH83yxw1F4UWB1QWi/0bYVNbis6llHsIf4e+coZ+lANxT5Xq7hY10a6XltAO4Y
         Ziq43hvu1ThB8TrYzpLQqUtQxoYTy0FFLe0uPRWXS/pWitRqSXGH0gqOxzon5I4jWDFW
         lAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=mXZwP2hoczQfrlEydy4jWIW1BdPXbgXaZJRNxyejTsM=;
        b=NZZMkfXh/W1VUSSvHRj9Tv7e8dJHJvh0cn8f5I6W0RumEoCOJb+6xN0QiIvMJtjH77
         YIwD0r1q8sWqtBqlm36XUWCG97QOnYRkVjsm4qTCDhf6VC/ESNa04pXQe3KTw3eEqqwW
         lCTsMXrbGE99GWquichhqmArpDU5Cg5VFumpvteZSND9LADICI/iqSnTNCYwk0ceyBbq
         mFg2HBr/iBC9MUm2H8h6hz9Us962TpsWfzPT+q52f7N00dB/FgHOEXEHhTtRK7PLQojh
         uk6KfviRN9xz1HaSwVEfuY5kwYUNuCeuEHrV/Lg524Ai0tzzFB7UbUOGLbmCuiTc89uc
         cMJg==
X-Gm-Message-State: APjAAAXsBBwc5+pHf+gtGkIUz0+/1mYrKHnbLx+vTGY7I7XL9E+W7TLw
        rjJW3Ubx9p4a/Q9kiDalicwDjqens/Q=
X-Google-Smtp-Source: APXvYqxk6EqBUMO8MrnRxMilSSOTHVn05ZKiK8/aHuuV3Fm0aoDDcciW9XXiWL+UpirbwjuLLcZ0bA==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr27534139wrw.138.1564141536245;
        Fri, 26 Jul 2019 04:45:36 -0700 (PDT)
Received: from ?IPv6:2a01:36d:104:9516:240c:2511:8205:6d7f? (2a01-036d-0104-9516-240c-2511-8205-6d7f.pool6.digikabel.hu. [2a01:36d:104:9516:240c:2511:8205:6d7f])
        by smtp.gmail.com with ESMTPSA id c3sm55863081wrx.19.2019.07.26.04.45.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 04:45:35 -0700 (PDT)
From:   Zoltan Karcagi <zkr7432@gmail.com>
Subject: BUG: "Stale file handle" error when connecting to ARM server
To:     linux-nfs@vger.kernel.org
Message-ID: <5bcd51ef-9ffb-2650-108f-8d7b04beb655@gmail.com>
Date:   Fri, 26 Jul 2019 13:45:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Upgrading the nfs-utils package from 2.3.4 to 2.4.1 on my nas device
running Arch Linux ARM (alarm) broke the nfs server functionality.
On all of my clients, mount fails with a "Stale file handle" error. On the
server, I get this (side note: the reported version number is wrong):

Jul 08 10:28:50 nas rpc.mountd[19752]: Version 2.3.4 starting
Jul 08 10:30:08 nas rpc.mountd[19752]: auth_unix_ip: inbuf 'nfsd <redacted valid ipv6 address>'
Jul 08 10:30:08 nas rpc.mountd[19752]: auth_unix_ip: client 0x492c50 'zero.local'
Jul 08 10:30:08 nas rpc.mountd[19752]: nfsd_fh: inbuf 'zero.local 1 \x00000000'
Jul 08 10:30:08 nas rpc.mountd[19752]: nfsd_fh: found 0x49b698 path /srv/nfs
Jul 08 10:30:08 nas rpc.mountd[19752]: nfsd_export: inbuf 'zero.local /srv/nfs/tmp2'
Jul 08 10:30:09 nas rpc.mountd[19752]: nfsd_export: found 0x499ed0 path /srv/nfs/tmp2
Jul 08 10:30:09 nas rpc.mountd[19752]: nfsd_fh: inbuf 'zero.local 7 \x0100140000000000ae18d6965c0a40f78701c770897a4fc>
Jul 08 10:30:09 nas rpc.mountd[19752]: nfsd_fh: found (nil) path (null)

Analysis:

Consider this code snippet from utils/mountd/cache.c:
 627 static bool match_fsid(struct parsed_fsid *parsed, nfs_export *exp, char *path)
 628 {
 629         struct stat stb;
 630         int type;
 631         char u[16];
 632
 633         if (nfsd_path_stat(path, &stb) != 0)
 634                 return false;

Variable stb gets defined, then gets filled by nfs_path_stat(), which is
implemented in support/misc/nfsd_path.c. At least on alarm, definition of
struct stat in stat.h depends on __USE_FILE_OFFSET64, which comes from
config.h if defined. This requires config.h to be included before stat.h.

The include order is right in cache.c, however, it's reversed in 
nfsd_path.c. This causes the data returned by nfs_path_stat() to be in a
different structure than expected, and that's what eventually causes the
error.    

Proposed solution:

The following patch fixes those occurrences where the include order
between config.h and stat.h is wrong, by moving config.h to the top.


Regards,
Zoltan Karcagi

