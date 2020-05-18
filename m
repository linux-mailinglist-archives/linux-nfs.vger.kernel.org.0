Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAA31D7FCE
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2020 19:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgERRPH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 May 2020 13:15:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59583 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbgERRPH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 May 2020 13:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589822105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nFMTfkv/NkzOqdDO37Xo7DK/iyESHb9LuD/EZo2wMs=;
        b=TVySwKeEkJFlCcx7PbvAWmzm+KMXKGebixX03LokvmTGGrCX4c+SJCN1hW7/JLgwqXx5fv
        ij1Z/C12oAygEIOnq2kUuRTo/GaCHMSnhPeOLDtviUF2VTaCX11RsgIzgS90fyn5DEfibw
        ibWesOJmwm8KD8W9m4arom8Qxejh2ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-q7lL0dWdNCGpgALc9oJbqw-1; Mon, 18 May 2020 13:14:58 -0400
X-MC-Unique: q7lL0dWdNCGpgALc9oJbqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFFF835B43
        for <linux-nfs@vger.kernel.org>; Mon, 18 May 2020 17:14:54 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-189.phx2.redhat.com [10.3.113.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5297D3A2
        for <linux-nfs@vger.kernel.org>; Mon, 18 May 2020 17:14:54 +0000 (UTC)
Subject: Re: [PATCH V2 2/2] nfsdclnts: add man page for tool nfsdclnts
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200518141050.74702-1-steved@redhat.com>
 <20200518141050.74702-2-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c2d18166-e364-d1ad-90f1-4cd2cc89117e@RedHat.com>
Date:   Mon, 18 May 2020 13:14:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518141050.74702-2-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/18/20 10:10 AM, Steve Dickson wrote:
> From: Achilles Gaikwad <agaikwad@redhat.com>
> 
> This patch adds man page for the tool nfsdclnts.
> 
> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed (tag: nfs-utils-2-4-4-rc5)

steved.
> ---
>  tools/nfsdclnts/Makefile.am   |   4 +
>  tools/nfsdclnts/nfsdclnts.man | 156 ++++++++++++++++++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 tools/nfsdclnts/nfsdclnts.man
> 
> v2: Renamed command to nfsdclnts
> 
> diff --git a/tools/nfsdclnts/Makefile.am b/tools/nfsdclnts/Makefile.am
> index c1f12a0..d513edb 100644
> --- a/tools/nfsdclnts/Makefile.am
> +++ b/tools/nfsdclnts/Makefile.am
> @@ -1,6 +1,10 @@
>  ## Process this file with automake to produce Makefile.in
>  PYTHON_FILES = nfsdclnts.py
>  
> +man8_MANS       = nfsdclnts.man
> +
> +EXTRA_DIST      = $(man8_MANS) $(PYTHON_FILES)
> +
>  all-local: $(PYTHON_FILES)
>  
>  install-data-hook:
> diff --git a/tools/nfsdclnts/nfsdclnts.man b/tools/nfsdclnts/nfsdclnts.man
> new file mode 100644
> index 0000000..3701de9
> --- /dev/null
> +++ b/tools/nfsdclnts/nfsdclnts.man
> @@ -0,0 +1,156 @@
> +.\"
> +.\" nfsdclnts(8)
> +.\"
> +.TH "NFSDCLTS" "8" "2020-05-09" "nfsdclnts" "nfsdclnts"
> +.ie \n(.g .ds Aq \(aq
> +.el       .ds Aq '
> +.ss \n[.ss] 0
> +.nh
> +.ad l
> +.de URL
> +\fI\\$2\fP <\\$1>\\$3
> +..
> +.als MTO URL
> +.if \n[.g] \{\
> +.  mso www.tmac
> +.  am URL
> +.    ad l
> +.  .
> +.  am MTO
> +.    ad l
> +.  .
> +.  LINKSTYLE blue R < >
> +.\}
> +.SH "NAME"
> +nfsdclnts \- print various nfs client information for knfsd server.
> +.SH "SYNOPSIS"
> +.sp
> +\fBnfsdclnts\fP [\fI\-h\fP] [\fI\-t type\fP] [\fI\-\-clientinfo\fP] [\fI\-\-hostname\fP] [\fI\-q\fP]
> +.SH "DESCRIPTION"
> +.sp
> +The nfsdclnts(8) command parses the content present in /proc/fs/nfsd/clients/ directories. nfsdclnts(8) displays files which are open, locked, delegated by the nfs\-client. It also prints useful client information such as hostname, clientID, NFS version mounted by the nfs\-client.
> +.SH "OPTIONS"
> +.sp
> +\fB\-t, \-\-type\fP=TYPE
> +.RS 4
> +Specify the type of file to be displayed. Takes only one TYPE at a time.
> +.sp
> +\fIopen\fP, \fIlock\fP, \fIdeleg\fP, \fIlayout\fP, or \fIall\fP
> +.sp
> +open: displays the open files by nfs\-client(s).
> +.sp
> +lock: displays the files locked by nfs\-client(s).
> +.sp
> +layout: displays the files for which layout is given.
> +.sp
> +deleg: displays delegated files information and delegation type.
> +.sp
> +all: prints all the above type.
> +.RE
> +.sp
> +\fB\-\-clientinfo\fP
> +.RS 4
> +displays various nfs\-client info fields such as version of nfs mounted at nfs\-client and clientID.
> +.RE
> +.sp
> +\fB\-\-hostname\fP
> +.RS 4
> +Print hostname of nfs\-client instead of ip-address.
> +.RE
> +.sp
> +\fB\-q, \-\-quiet\fP
> +.RS 4
> +Hide the header information.
> +.RE
> +.sp
> +\fB\-h, \-\-help\fP
> +.RS 4
> +Print help explaining the command line options.
> +.SH "EXAMPLES"
> +.sp
> +\fBnfsdclnts \-\-type open\fP
> +.RS 4
> +List all files with open type only.
> +.RE
> +.sp
> +.if n .RS 4
> +.nf
> +Inode number | Type   | Access | Deny | ip address            | Filename
> +33823232     | open   | r\-     | \-\-   | [::1]:757             | testfile
> +.fi
> +.if n .RE
> +.sp
> +\fBnfsdclnts \-\-type deleg\fP
> +.RS 4
> +List all files with deleg type only.
> +.RE
> +.sp
> +.if n .RS 4
> +.nf
> +Inode number | Type   | Access | ip address            | Filename
> +33823232     | deleg  | r      | [::1]:757             | testfile
> +.fi
> +.if n .RE
> +.sp
> +\fBnfsdclnts \-\-hostname\fP
> +.RS 4
> +Print hostname instead of ip\-address.
> +.RE
> +.sp
> +.if n .RS 4
> +.nf
> +Inode number | Type   | Access | Deny | Hostname              | Filename
> +33823232     | open   | r\-     | \-\-   | nfs\-server            | testfile
> +33823232     | deleg  | r      |      | nfs\-server            | testfile
> +.fi
> +.if n .RE
> +.sp
> +\fBnfsdclnts \-\-clientinfo\fP
> +.RS 4
> +Print client information.
> +.RE
> +.sp
> +.if n .RS 4
> +.nf
> +Inode number | Type   | Access | Deny | ip address            | Client ID           | vers | Filename
> +33823232     | open   | r\-     | \-\-   | [::1]:757             | 0xc79a009f5eb65e84  | 4.2  | testfile
> +33823232     | deleg  | r      |      | [::1]:757             | 0xc79a009f5eb65e84  | 4.2  | testfile
> +.fi
> +.if n .RE
> +.sp
> +\fBnfsdclnts.py \-\-quiet \-\-hostname\fP
> +.RS 4
> +Hide the header information.
> +.RE
> +.sp
> +.if n .RS 4
> +.nf
> +33823232     | open   | r\-     | \-\-   | nfs\-server            | testfile
> +33823232     | deleg  | r      |      | nfs\-server            | testfile
> +.fi
> +.if n .RE
> +.SH "FILES"
> +.sp
> +\fB/proc/fs/nfsd/clients/\fP
> +.sp
> +Displays basic information about each NFSv4 client.
> +.sp
> +\fB/proc/fs/nfsd/clients/#/info\fP
> +.sp
> +Displays information about all the opens held by the given client, including open modes, device numbers, inode numbers, and open owners.
> +.sp
> +\fB/proc/fs/nfsd/clients/#/states\fP
> +.SH "NOTES"
> +.sp
> +/proc/fs/nfsd/clients/ support was initially introduced in 5.3 kernel and is only implemented for mount points using NFSv4.
> +.SH "BUGS"
> +Please report any BUGs to \c
> +.MTO "linux\-nfs\(atvger.kernel.org" "" ""
> +.SH SEE ALSO
> +.BR nfsd (8),
> +.BR exportfs (8),
> +.BR idmapd (8),
> +.BR statd (8)
> +.SH "AUTHORS"
> +Achilles Gaikwad <agaikwad@redhat.com> and
> +Kenneth D'souza  <kdsouza@redhat.com>
> 

