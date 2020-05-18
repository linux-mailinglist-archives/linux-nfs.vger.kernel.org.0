Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A081D7A69
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2020 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgERNuu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 May 2020 09:50:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23544 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726895AbgERNuu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 May 2020 09:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589809848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfcWS7cy/wZ66qd1V/V0WXOGJ7vMTCwhTJEUyARLR/o=;
        b=MkAlp7vwo/fOm7eoqlp4uS2GeHmuTn+iIJ7kWuwbcXS3p3zj+LcUXhhoM23ThhzbgZ4pfR
        9HniRtIBdLpYL3IZ/20mshjdKndjdvfiEmvkLuhzfc+XqmRezWPGmuQA3F+jHauZHM9Dr9
        T9UnQWzSloEmeFqqHxgjrELe6Iq1AS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-YdmF4hxbMSudODHq6gMrgw-1; Mon, 18 May 2020 09:50:40 -0400
X-MC-Unique: YdmF4hxbMSudODHq6gMrgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFD0619057A1
        for <linux-nfs@vger.kernel.org>; Mon, 18 May 2020 13:50:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-189.phx2.redhat.com [10.3.113.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 774DC6EA04
        for <linux-nfs@vger.kernel.org>; Mon, 18 May 2020 13:50:39 +0000 (UTC)
Subject: Re: [PATCH] nfsdclddb: Redname clddb-tool to nfsdclddb
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200513162950.186930-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <80242f7d-ebd7-7510-4694-97f0a005e828@RedHat.com>
Date:   Mon, 18 May 2020 09:50:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513162950.186930-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/13/20 12:29 PM, Steve Dickson wrote:
> To try to maintain some type of name convention
> rename clddb-tool to nfsdclddb
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... 

steved.

> ---
>  configure.ac                                  |  2 +-
>  tools/Makefile.am                             |  2 +-
>  tools/{clddb-tool => nfsdclddb}/Makefile.am   |  6 +++---
>  .../nfsdclddb.man}                            | 20 +++++++++----------
>  .../clddb-tool.py => nfsdclddb/nfsdclddb.py}  |  0
>  5 files changed, 15 insertions(+), 15 deletions(-)
>  rename tools/{clddb-tool => nfsdclddb}/Makefile.am (60%)
>  rename tools/{clddb-tool/clddb-tool.man => nfsdclddb/nfsdclddb.man} (84%)
>  rename tools/{clddb-tool/clddb-tool.py => nfsdclddb/nfsdclddb.py} (100%)
> 
> diff --git a/configure.ac b/configure.ac
> index df88e58..0b1c8cc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -695,7 +695,7 @@ AC_CONFIG_FILES([
>  	tools/mountstats/Makefile
>  	tools/nfs-iostat/Makefile
>  	tools/nfsconf/Makefile
> -	tools/clddb-tool/Makefile
> +	tools/nfsdclddb/Makefile
>  	utils/Makefile
>  	utils/blkmapd/Makefile
>  	utils/nfsdcld/Makefile
> diff --git a/tools/Makefile.am b/tools/Makefile.am
> index 53e6117..432d35d 100644
> --- a/tools/Makefile.am
> +++ b/tools/Makefile.am
> @@ -9,7 +9,7 @@ endif
>  OPTDIRS += nfsconf
>  
>  if CONFIG_NFSDCLD
> -OPTDIRS += clddb-tool
> +OPTDIRS += nfsdclddb
>  endif
>  
>  SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat $(OPTDIRS)
> diff --git a/tools/clddb-tool/Makefile.am b/tools/nfsdclddb/Makefile.am
> similarity index 60%
> rename from tools/clddb-tool/Makefile.am
> rename to tools/nfsdclddb/Makefile.am
> index 15a8fd4..18263fb 100644
> --- a/tools/clddb-tool/Makefile.am
> +++ b/tools/nfsdclddb/Makefile.am
> @@ -1,13 +1,13 @@
>  ## Process this file with automake to produce Makefile.in
> -PYTHON_FILES =  clddb-tool.py
> +PYTHON_FILES =  nfsdclddb.py
>  
> -man8_MANS	= clddb-tool.man
> +man8_MANS	= nfsdclddb.man
>  
>  EXTRA_DIST	= $(man8_MANS) $(PYTHON_FILES)
>  
>  all-local: $(PYTHON_FILES)
>  
>  install-data-hook:
> -	$(INSTALL) -m 755 clddb-tool.py $(DESTDIR)$(sbindir)/clddb-tool
> +	$(INSTALL) -m 755 nfsdclddb.py $(DESTDIR)$(sbindir)/nfsdclddb
>  
>  MAINTAINERCLEANFILES=Makefile.in
> diff --git a/tools/clddb-tool/clddb-tool.man b/tools/nfsdclddb/nfsdclddb.man
> similarity index 84%
> rename from tools/clddb-tool/clddb-tool.man
> rename to tools/nfsdclddb/nfsdclddb.man
> index e80b2c0..8ec7b18 100644
> --- a/tools/clddb-tool/clddb-tool.man
> +++ b/tools/nfsdclddb/nfsdclddb.man
> @@ -1,20 +1,20 @@
>  .\"
> -.\" clddb-tool(8)
> +.\" nfsdclddb(8)
>  .\"
> -.TH clddb-tool 8 "07 Aug 2019"
> +.TH nfsdclddb 8 "07 Aug 2019"
>  .SH NAME
> -clddb-tool \- Tool for manipulating the nfsdcld sqlite database
> +nfsdclddb \- Tool for manipulating the nfsdcld sqlite database
>  .SH SYNOPSIS
> -.B clddb-tool
> +.B nfsdclddb
>  .RB [ \-h | \-\-help ]
>  .P
> -.B clddb-tool
> +.B nfsdclddb
>  .RB [ \-p | \-\-path
>  .IR dbpath ]
>  .B fix-table-names
>  .RB [ \-h | \-\-help ]
>  .P
> -.B clddb-tool
> +.B nfsdclddb
>  .RB [ \-p | \-\-path
>  .IR dbpath ]
>  .B downgrade-schema
> @@ -22,7 +22,7 @@ clddb-tool \- Tool for manipulating the nfsdcld sqlite database
>  .RB [ \-v | \-\-version
>  .IR to-version ]
>  .P
> -.B clddb-tool
> +.B nfsdclddb
>  .RB [ \-p | \-\-path
>  .IR dbpath ]
>  .B print
> @@ -31,10 +31,10 @@ clddb-tool \- Tool for manipulating the nfsdcld sqlite database
>  .P
>  
>  .SH DESCRIPTION
> -.RB "The " clddb-tool " command is provided to perform some manipulation of the nfsdcld sqlite database schema and to print the contents of the database."
> +.RB "The " nfsdclddb " command is provided to perform some manipulation of the nfsdcld sqlite database schema and to print the contents of the database."
>  .SS Sub-commands
>  Valid
> -.B clddb-tool
> +.B nfsdclddb
>  subcommands are:
>  .IP "\fBfix-table-names\fP"
>  .RB "A previous version of " nfsdcld "(8) contained a bug that corrupted the reboot epoch table names.  This sub-command will fix those table names."
> @@ -66,7 +66,7 @@ The schema version to downgrade to.  Currently the schema can only be downgraded
>  Do not list the clients in the reboot epoch tables in the output.
>  .SH NOTES
>  The
> -.B clddb-tool
> +.B nfsdclddb
>  command will not allow the
>  .B fix-table-names
>  or
> diff --git a/tools/clddb-tool/clddb-tool.py b/tools/nfsdclddb/nfsdclddb.py
> similarity index 100%
> rename from tools/clddb-tool/clddb-tool.py
> rename to tools/nfsdclddb/nfsdclddb.py
> 

