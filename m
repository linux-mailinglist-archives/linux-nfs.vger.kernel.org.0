Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607171BF6C
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfEMWYn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 18:24:43 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:53792 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfEMWYm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 May 2019 18:24:42 -0400
Received: by mail-it1-f170.google.com with SMTP id m141so1777325ita.3
        for <linux-nfs@vger.kernel.org>; Mon, 13 May 2019 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lanfear.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=SV05nwYcuHDSSIzrFSLPm8AoEoo38cXUUzjB8sE60Ok=;
        b=DIr625JLUFpz8Mhsfef05hOFicp+iypRHh8IPpH815aAtneIXT6a+b4uUwviEn9Fi9
         e0rcmKmfg/m+g+R6k+MYxBuVkwbX59Bx/LcojDRDVgQhKmRq773LIGOm/YK6plbV9QTt
         8ecEVl5XP5y3x/kQJNvTZuzpjL6KrXJ6e0gq2fa66sY3eH1ZFFV3Zs5nWzv/PkS8KRPq
         3M3hYKc9ysfLlSzEi2uU88mZSNbCVl3usyOsOWrN+LXA99D8HpFM24I1KlTXq1o+v4Hf
         l3CpRgURakemyvt0Aej4zuwDSgbvCdHp181F4bqk/jflEemrijYy4HZwWxP4m9rF1b9Z
         F+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SV05nwYcuHDSSIzrFSLPm8AoEoo38cXUUzjB8sE60Ok=;
        b=oxOnkuMjid8uSLC23e6krbrlaYGUqxg5PUZJLNESD0BvBRALDwnH0dkDj1S7niCNZA
         spv8qR9ag/+BKZNqGB+i5jLOoKgB39fEN4Q0m+nrMPt1txQXV7Rku1k8Eu6VnpesmqtA
         zlGMgGnS8OiG2Pv7y5oLYBSFOeiSuVDciP3IrowCxYjVnmPWoQ/+tisWE8DxEWwUOYKU
         +EuTXvaz45y2VeU2ml49Y/0E6iDibn6B2s4m3PJO7OAqiNjKLfJE7CEbi+7llghfsDMx
         b5MvOb269LvWfhlVLhcYnGh88VuoIwtSw9HYyz1NGoGuhFEelyQVKb9NIewt9X6NPD2X
         CLaA==
X-Gm-Message-State: APjAAAU1jvq0SajBr8tukdiunKJ5uBnxZT40OtzZkcjcWURJ3syjMbue
        DCQf//XdtOQaRiklg7nQ6eNoINHMI1SdF4BlnjVCF9CvjqBh6Q==
X-Google-Smtp-Source: APXvYqycwBSP1xU5U+V9asqwM6g4m7qHeKYpX2QF5J8lVpezbWLp1LwiyvsdiTRtsH2Z280nX4FRH0OKAGtv0Lu+eOM=
X-Received: by 2002:a02:c88d:: with SMTP id m13mr21703501jao.63.1557786281722;
 Mon, 13 May 2019 15:24:41 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Wagner <mark@lanfear.net>
Date:   Mon, 13 May 2019 15:24:06 -0700
Message-ID: <CALUOdrwv6RHwFCbPBmsZfY0o_18cP_o-y7Sj_O4OfEKK1MxEfw@mail.gmail.com>
Subject: Bug report: rpc.mountd segv due to commit 8f459a072f93458fc2198ce1962b279164aa9059
 Remove abuse of ai_canonname
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

(gdb) run -F
Starting program: /usr/sbin/rpc.mountd -F
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
rpc.mountd: Version 2.3.4 starting

Program received signal SIGSEGV, Segmentation fault.
0x0000555555564921 in DoMatch (text=0x0, p=0x5555555af100
"knode*.lanfear.net") at wildmat.c:75
75      wildmat.c: No such file or directory.
(gdb) bt
#0  0x0000555555564921 in DoMatch (text=0x0, p=0x5555555af100
"knode*.lanfear.net") at wildmat.c:75
#1  0x0000555555564b69 in wildmat (text=text@entry=0x0,
p=p@entry=0x5555555af100 "knode*.lanfear.net") at wildmat.c:140
#2  0x000055555555e9ab in check_wildcard (clp=<optimized out>,
ai=<optimized out>) at client.c:616
#3  client_check (ai=<optimized out>, clp=<optimized out>) at client.c:740
#4  client_check (clp=<optimized out>, ai=<optimized out>) at client.c:732
#5  0x000055555555edb4 in client_compose (ai=ai@entry=0x5555555ac830)
at client.c:417
#6  0x000055555555c0f3 in auth_unix_ip (f=3) at cache.c:115
#7  0x000055555555d95a in cache_process_req
(readfds=readfds@entry=0x7fffffffdc90) at cache.c:1417
#8  0x000055555555de28 in my_svc_run () at svc_run.c:118
#9  0x000055555555941a in main (argc=<optimized out>, argv=<optimized
out>) at mountd.c:892

The commit message says "There is only one caller to
host_reliable_addrinfo() that actually uses the string in
ai->ai_canonname, and then only for debugging messages. Change those
to display the IP address instead."

That is not quite right. ./support/export/client.c check_wildcard()
uses ai_canonname:

static int
check_wildcard(const nfs_client *clp, const struct addrinfo *ai)
{
        char *cname = clp->m_hostname;
        char *hname = ai->ai_canonname;
...

Kernel versions:
server: 5.0.10-gentoo
client: 5.0.10-200.fc29.x86_64

nfs-utils version: 2.3.4

"Are you using any of the security options?" No.

exportfs -v
/usr/local/k8s
knode*.lanfear.net(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)

-- 
Mark Wagner <mark@lanfear.net>
