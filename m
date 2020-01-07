Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3285132F9E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2020 20:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgAGTjD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jan 2020 14:39:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728440AbgAGTjD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jan 2020 14:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578425941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QY83TwxUR4noy9CWRWKZzealgHaOMVAVpHxrhBbZwGw=;
        b=BDWtKWQ7TfrtomLyT48ks1hF5OOZ3rdGlcLV8Gv4v6f0ohHqUBy9OCfwuuqXmYEzdNiz+A
        1Kg+l2C063wyToImM50bhPuih5qmdcjnJEhbX7lf/tEzDDX3JfVlU8EmIdgYRJ73fZRihj
        8PLxovyfK4vaFIlFM7/m5aL9mwm8bkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-syYp-Cc7MduRHop1FrqhlA-1; Tue, 07 Jan 2020 14:39:00 -0500
X-MC-Unique: syYp-Cc7MduRHop1FrqhlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B19107ACC5;
        Tue,  7 Jan 2020 19:38:59 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-217.phx2.redhat.com [10.3.117.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBCFE19C58;
        Tue,  7 Jan 2020 19:38:58 +0000 (UTC)
Subject: Re: [nfs-utils RESENT PATCH 1/1] locktes/rpcgen: tweak how we
 override compiler settings
From:   Steve Dickson <SteveD@RedHat.com>
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
Cc:     Mike Frysinger <vapier@gentoo.org>
References: <20200105120502.765426-1-petr.vorel@gmail.com>
 <fb4dd073-856a-7807-eb71-f594e58732cb@RedHat.com>
Message-ID: <bda9e61c-1a06-5ab3-339f-c38e9a68fb73@RedHat.com>
Date:   Tue, 7 Jan 2020 14:38:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fb4dd073-856a-7807-eb71-f594e58732cb@RedHat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/7/20 2:20 PM, Steve Dickson wrote:
> 
> 
> On 1/5/20 7:05 AM, Petr Vorel wrote:
>> From: Mike Frysinger <vapier@gentoo.org>
>>
>> Newer autotools will use both CFLAGS and <target>_CFLAGS when compiling
>> the <target>.  Adding the build settings to the target-specific flags no
>> longer works as a way to compile build-time tools.
>>
>> Instead, clobber the global flags.  This triggers an automake warning,
>> but the end result actually works (unlike the existing code).
>>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
>> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
>> ---
>> Hi Steve,
>>
>> this patch was sent by Mike in 2013 [1]. You had some objections about
>> warnings it causes [2]. Although I understand it, I'd like it was merged,
>> because it's needed (taken by distros: gentoo [3], buildroot [4]) and
>> IMHO it cannot be implemented other way.
>>
>> Also not sure, what should be changed in automake to avoid this tweek
>> (I might ask upstream).
>>
>> Kind regards,
>> Petr
>>
>> [1] https://marc.info/?l=linux-nfs&m=136416341629788&w=2
>> [2] https://marc.info/?l=linux-nfs&m=136423027217638&w=2
>> [3] https://gitweb.gentoo.org/repo/gentoo.git/tree/net-fs/nfs-utils/files/nfs-utils-1.2.8-cross-build.patch
>> [4] https://git.busybox.net/buildroot/tree/package/nfs-utils/0001-Patch-taken-from-Gentoo.patch
>>
> Yes I do remember the conversation.... So you are saying using AM_XXXX macros 
> like the following patch does not take care of the problem? 
> 
Actually try this one... the one that works! ;-) 

diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
index 3156815..d5cf8da 100644
--- a/tools/locktest/Makefile.am
+++ b/tools/locktest/Makefile.am
@@ -1,12 +1,11 @@
 ## Process this file with automake to produce Makefile.in
 
 CC=$(CC_FOR_BUILD)
-LIBTOOL = @LIBTOOL@ --tag=CC
+AM_CFLAGS=$(CFLAGS_FOR_BUILD)
+AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
+AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 noinst_PROGRAMS = testlk
 testlk_SOURCES = testlk.c
-testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
-testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
-testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
index 8a9ec89..84cafb2 100644
--- a/tools/rpcgen/Makefile.am
+++ b/tools/rpcgen/Makefile.am
@@ -1,7 +1,9 @@
 ## Process this file with automake to produce Makefile.in
 
 CC=$(CC_FOR_BUILD)
-LIBTOOL = @LIBTOOL@ --tag=CC
+AM_CFLAGS=$(CFLAGS_FOR_BUILD) ${TIRPC_CFLAGS}
+AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
+AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 noinst_PROGRAMS = rpcgen
 rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
@@ -9,11 +11,6 @@ rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
                 rpc_util.c rpc_sample.c rpc_output.h rpc_parse.h \
                 rpc_scan.h rpc_util.h
 
-rpcgen_CFLAGS=$(CFLAGS_FOR_BUILD)
-rpcgen_CPPLAGS=$(CPPFLAGS_FOR_BUILD)
-rpcgen_LDFLAGS=$(LDFLAGS_FOR_BUILD)
-rpcgen_LDADD=$(LIBTIRPC)
-
 MAINTAINERCLEANFILES = Makefile.in
 
 EXTRA_DIST = rpcgen.new.1

