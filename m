Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19D1CCBD2
	for <lists+linux-nfs@lfdr.de>; Sun, 10 May 2020 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgEJPLn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 May 2020 11:11:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728762AbgEJPLn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 May 2020 11:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589123501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TdahuzsieweADx+tV9ejsKiSZGV8QZ8I81+5RDz8Q5k=;
        b=A8T0AZiJTV2Z2WgifQxGuVUNJP6gi0Xsttg4xIXxrQxv4Dn6FAineiRy4bEGJ8Mmnu1pEd
        +ZLchuAqkE0Z7aXWuHuoMOM5NsOgbUvYK0AI+KYOcCR4BGe5HFPq4Dm5NcwOHtK52lYLPk
        2Z7CdAG4CLmaXc9VNA2xn1qCCv22YpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-MCu7boCPOLy4SF65Du7g4g-1; Sun, 10 May 2020 11:11:37 -0400
X-MC-Unique: MCu7boCPOLy4SF65Du7g4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57857100A8EA;
        Sun, 10 May 2020 15:11:36 +0000 (UTC)
Received: from nevermore.foobar.lan (unknown [10.74.8.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 602AF10016E8;
        Sun, 10 May 2020 15:11:34 +0000 (UTC)
Date:   Sun, 10 May 2020 20:41:30 +0530
From:   Achilles Gaikwad <agaikwad@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, bfields@fieldses.org, kdsouza@redhat.com,
        agaikwad@redhat.com
Subject: [PATCH] add man page for tool nfsdclts
Message-ID: <20200510151130.GA1295654@nevermore.foobar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch adds man page for the tool nfsdclts.

Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 tools/nfsdclts/Makefile.am  |   4 +
 tools/nfsdclts/nfsdclts.man | 156 ++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 tools/nfsdclts/nfsdclts.man

diff --git a/tools/nfsdclts/Makefile.am b/tools/nfsdclts/Makefile.am
index 5fe2c1b2..6e24efe0 100644
--- a/tools/nfsdclts/Makefile.am
+++ b/tools/nfsdclts/Makefile.am
@@ -1,6 +1,10 @@
 ## Process this file with automake to produce Makefile.in
 PYTHON_FILES = nfsdclts.py
 
+man8_MANS       = nfsdclts.man
+
+EXTRA_DIST      = $(man8_MANS) $(PYTHON_FILES)
+
 all-local: $(PYTHON_FILES)
 
 install-data-hook:
diff --git a/tools/nfsdclts/nfsdclts.man b/tools/nfsdclts/nfsdclts.man
new file mode 100644
index 00000000..139814c5
--- /dev/null
+++ b/tools/nfsdclts/nfsdclts.man
@@ -0,0 +1,156 @@
+.\"
+.\" nfsdclts(8)
+.\"
+.TH "NFSDCLTS" "8" "2020-05-09" "nfsdclts" "nfsdclts"
+.ie \n(.g .ds Aq \(aq
+.el       .ds Aq '
+.ss \n[.ss] 0
+.nh
+.ad l
+.de URL
+\fI\\$2\fP <\\$1>\\$3
+..
+.als MTO URL
+.if \n[.g] \{\
+.  mso www.tmac
+.  am URL
+.    ad l
+.  .
+.  am MTO
+.    ad l
+.  .
+.  LINKSTYLE blue R < >
+.\}
+.SH "NAME"
+nfsdclts \- print various nfs client information for knfsd server.
+.SH "SYNOPSIS"
+.sp
+\fBnfsdclts\fP [\fI\-h\fP] [\fI\-t type\fP] [\fI\-\-clientinfo\fP] [\fI\-\-hostname\fP] [\fI\-q\fP]
+.SH "DESCRIPTION"
+.sp
+The nfsdclts(8) command parses the content present in /proc/fs/nfsd/clients/ directories. nfsdclts(8) displays files which are open, locked, delegated by the nfs\-client. It also prints useful client information such as hostname, clientID, NFS version mounted by the nfs\-client.
+.SH "OPTIONS"
+.sp
+\fB\-t, \-\-type\fP=TYPE
+.RS 4
+Specify the type of file to be displayed. Takes only one TYPE at a time.
+.sp
+\fIopen\fP, \fIlock\fP, \fIdeleg\fP, \fIlayout\fP, or \fIall\fP
+.sp
+open: displays the open files by nfs\-client(s).
+.sp
+lock: displays the files locked by nfs\-client(s).
+.sp
+layout: displays the files for which layout is given.
+.sp
+deleg: displays delegated files information and delegation type.
+.sp
+all: prints all the above type.
+.RE
+.sp
+\fB\-\-clientinfo\fP
+.RS 4
+displays various nfs\-client info fields such as version of nfs mounted at nfs\-client and clientID.
+.RE
+.sp
+\fB\-\-hostname\fP
+.RS 4
+Print hostname of nfs\-client instead of ip-address.
+.RE
+.sp
+\fB\-q, \-\-quiet\fP
+.RS 4
+Hide the header information.
+.RE
+.sp
+\fB\-h, \-\-help\fP
+.RS 4
+Print help explaining the command line options.
+.SH "EXAMPLES"
+.sp
+\fBnfsdclts \-\-type open\fP
+.RS 4
+List all files with open type only.
+.RE
+.sp
+.if n .RS 4
+.nf
+Inode number | Type   | Access | Deny | ip address            | Filename
+33823232     | open   | r\-     | \-\-   | [::1]:757             | testfile
+.fi
+.if n .RE
+.sp
+\fBnfsdclts \-\-type deleg\fP
+.RS 4
+List all files with deleg type only.
+.RE
+.sp
+.if n .RS 4
+.nf
+Inode number | Type   | Access | ip address            | Filename
+33823232     | deleg  | r      | [::1]:757             | testfile
+.fi
+.if n .RE
+.sp
+\fBnfsdclts \-\-hostname\fP
+.RS 4
+Print hostname instead of ip\-address.
+.RE
+.sp
+.if n .RS 4
+.nf
+Inode number | Type   | Access | Deny | Hostname              | Filename
+33823232     | open   | r\-     | \-\-   | nfs\-server            | testfile
+33823232     | deleg  | r      |      | nfs\-server            | testfile
+.fi
+.if n .RE
+.sp
+\fBnfsdclts \-\-clientinfo\fP
+.RS 4
+Print client information.
+.RE
+.sp
+.if n .RS 4
+.nf
+Inode number | Type   | Access | Deny | ip address            | Client ID           | vers | Filename
+33823232     | open   | r\-     | \-\-   | [::1]:757             | 0xc79a009f5eb65e84  | 4.2  | testfile
+33823232     | deleg  | r      |      | [::1]:757             | 0xc79a009f5eb65e84  | 4.2  | testfile
+.fi
+.if n .RE
+.sp
+\fBnfsdclts.py \-\-quiet \-\-hostname\fP
+.RS 4
+Hide the header information.
+.RE
+.sp
+.if n .RS 4
+.nf
+33823232     | open   | r\-     | \-\-   | nfs\-server            | testfile
+33823232     | deleg  | r      |      | nfs\-server            | testfile
+.fi
+.if n .RE
+.SH "FILES"
+.sp
+\fB/proc/fs/nfsd/clients/\fP
+.sp
+Displays basic information about each NFSv4 client.
+.sp
+\fB/proc/fs/nfsd/clients/#/info\fP
+.sp
+Displays information about all the opens held by the given client, including open modes, device numbers, inode numbers, and open owners.
+.sp
+\fB/proc/fs/nfsd/clients/#/states\fP
+.SH "NOTES"
+.sp
+/proc/fs/nfsd/clients/ support was initially introduced in 5.3 kernel and is only implemented for mount points using NFSv4.
+.SH "BUGS"
+Please report any BUGs to \c
+.MTO "linux\-nfs\(atvger.kernel.org" "" ""
+.SH SEE ALSO
+.BR nfsd (8),
+.BR exportfs (8),
+.BR idmapd (8),
+.BR statd (8)
+.SH "AUTHORS"
+Achilles Gaikwad <agaikwad@redhat.com> and
+Kenneth D'souza  <kdsouza@redhat.com>
-- 
2.26.2

