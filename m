Return-Path: <linux-nfs+bounces-3290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6306F8C9E39
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 15:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DD6287EAF
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7415253373;
	Mon, 20 May 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVpeBK3h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B542AE7C
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211944; cv=none; b=uIZeVd/EdXPaxYmJSTUz4Rnsmim+gQt76rmRrD+zJegRLbtt+0dRoS1wUZA2OTwjEnyZvXdZrZqhiMoYoIvFRrbsi3Eo4i7AJQD0ACG0UKnf+b05e+veJCHvPaK0AvCWRLWxHDNVz5vbMUZmMJNpmRbyK0oedGx0OdnVDUZ8Ts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211944; c=relaxed/simple;
	bh=v8QuTYWDOyNU1X+GLOLIkkpkKXRWshjUZMacfvrpwnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nNCmi1MrtwHRY8JxVkyUE+6kjVqeUDochep3WrNR9xh3SitzH8780ThZGtPPLqAcXrkko5SUrh7H6yYA9Ho5szOmooUjrKiFPZtMmlLjz+tRS9vYg9qF/aOZ252CodSh2RFOyLzCm4yMeImKDU6gmbzVijSGh7ytl7IbIhCQD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVpeBK3h; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b278cdfad6so1062137eaf.3
        for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716211941; x=1716816741; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojOavzsKP9GGUjBFOodn8N+6GfPaUnLGt1SXuqO4i/8=;
        b=BVpeBK3hIZLxOxcUCeG6V1o1sb26Jq3EzOTb6rfqz9iKI9S7hrOiLN1MDh61R9ae8q
         HIyuu54mtr9vi6Gn3xs1ouxF9cphibIjPheMYxaIKg11Xp8TPKjG26Iko5Fgm4MGD5Jp
         e9i4PLK6AlNM43138i4mQ8RKqa146ZDtTQn5+/MJklydIhAJbJPe2VlKLfZYhmWHJKrj
         Uo3kv7AvULaBilRHFBGtSyFr9P+tGaYaAdBF7g3oQbzbwMXZgXyIeol2hLRO1NW6P332
         ATZz9Qf4yJjrEECKe55nXitY889XW9H6X9QWb2T4FjZbIr11DZrfGjQK5aDs9/zcHlZG
         fRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716211941; x=1716816741;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojOavzsKP9GGUjBFOodn8N+6GfPaUnLGt1SXuqO4i/8=;
        b=SZ85EHnmuNUVCCAEOFdnMVWOtL4NcPdpdZIP6K0UZu7eJCN3B/CseajEZfqw02aS/v
         vwtxLQmi10VoOJSgTVVz29TVd+xJb/CMOCFdeAY2p/1WokyWZ2VBqREmujZgMZyB5x/R
         kK97cy+zo4c3LEOmhAHr9LLM8swf7i/Zw2yj72KSeI4nijd6AXdo9q8XxmAfZowN8B+o
         OEL7cxCbJIhfLz5uA6ZbKngVmb7B1cqW0XrpKEVXBaLYK1lw1417sjbH02YGg9boMukc
         DDkY96SgZ+/KjRJVaL7TRWKRV1HHey2lHdEAXgbspt8CxTG6vqhihLlstRUPqOPeyoEy
         HFVg==
X-Gm-Message-State: AOJu0YzZIIUhW8PJsmoURUWZAct97yV5bO6nrz0O5RFrUMek2nxIHZ2F
	BxKt1rkoiIiFV003PaK04nybgPkyhLBcRK80K03vZQWqaHFN8AZPZtIN0AC26+Myqf+772rbt4y
	KEE0VLgA+EXlkvenyJBmjOv62wNWHmJsXArI=
X-Google-Smtp-Source: AGHT+IFnTBZB9gYKa2GyMiIJNDLOOJfW4hq8PMu3ygzNbeUPKkKK6DcKxa2wXK/P7hM2MH8PGVEBlKtSLPpJO3tTp6M=
X-Received: by 2002:a4a:5186:0:b0:5aa:4d23:9114 with SMTP id
 006d021491bc7-5b2818a3733mr29092766eaf.3.1716211941511; Mon, 20 May 2024
 06:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <664b23a1.aDXCDCTVQgUaVqL+%james-p@moving-picture.com>
In-Reply-To: <664b23a1.aDXCDCTVQgUaVqL+%james-p@moving-picture.com>
From: James Pearson <jcpearson@gmail.com>
Date: Mon, 20 May 2024 14:32:09 +0100
Message-ID: <CAK3fRr9swwYJKGHMtUsfj0+hnuQLuiKUfsxOsoYuaa6vUb91Nw@mail.gmail.com>
Subject: [PATCH] nfs-utils: add priority option to override the precedence
 order of client exports
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Patch to override/manage the order of client specification exports
matches via the use of a priority option

The current client precedence match order is fixed, e.g. an IP subnet
match will be used before a wildcard match, but with this patch the
wildcard match can be given a higher priority (positive integer) value
and will be matched before the subnet match

Signed-off-by: James Pearson <jcpearson@gmail.com>
---
 support/export/auth.c      |  8 ++++++--
 support/export/cache.c     | 14 ++++++++++++++
 support/include/nfslib.h   |  1 +
 support/nfs/exports.c      | 12 ++++++++++++
 utils/exportfs/exportfs.c  |  2 ++
 utils/exportfs/exports.man | 19 ++++++++++++++++++-
 6 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/support/export/auth.c b/support/export/auth.c
index 2d7960f1..3d9e07b5 100644
--- a/support/export/auth.c
+++ b/support/export/auth.c
@@ -175,7 +175,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
                           const char *path, struct addrinfo *ai,
                           enum auth_error *error)
 {
-       nfs_export *exp;
+       nfs_export *exp, *found;
        int i;

        free(my_client.m_hostname);
@@ -189,6 +189,7 @@ auth_authenticate_newcache(const struct sockaddr *caller,
        my_exp.m_client = &my_client;

        exp = NULL;
+       found = NULL;
        for (i = 0; !exp && i < MCL_MAXTYPES; i++)
                for (exp = exportlist[i].p_head; exp; exp = exp->m_next) {
                        if (strcmp(path, exp->m_export.e_path))
@@ -198,8 +199,11 @@ auth_authenticate_newcache(const struct sockaddr *caller,
                        if (exp->m_export.e_flags & NFSEXP_V4ROOT)
                                /* not acceptable for v[23] export */
                                continue;
-                       break;
+                       /* we have a match - see if it is a higher priority */
+                       if (!found || exp->m_export.e_priority >
found->m_export.e_priority)
+                               found = exp;
                }
+       exp = found;
        *error = not_exported;
        if (!exp)
                return NULL;
diff --git a/support/export/cache.c b/support/export/cache.c
index 6c0a44a3..dfb0051b 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -877,6 +877,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
                                xlog(L_WARNING, "%s and %s have same
filehandle for %s, using first",
                                     found_path, path, dom);
                        } else {
+                               /* same path, see if this one has a
higher export priority */
+                               if (exp->m_export.e_priority >
found->e_priority) {
+                                       found = &exp->m_export;
+                                       free(found_path);
+                                       found_path = strdup(path);
+                                       if (found_path == NULL)
+                                               goto out;
+                               }
                                /* same path, if one is V4ROOT, choose
the other */
                                if (found->e_flags & NFSEXP_V4ROOT) {
                                        found = &exp->m_export;
@@ -1178,6 +1186,12 @@ lookup_export(char *dom, char *path, struct addrinfo *ai)
                                found_type = i;
                                continue;
                        }
+                       /* see if this one has a higher export priority */
+                       if (exp->m_export.e_priority >
found->m_export.e_priority) {
+                               found = exp;
+                               found_type = i;
+                               continue;
+                       }
                        /* Always prefer non-V4ROOT exports */
                        if (exp->m_export.e_flags & NFSEXP_V4ROOT)
                                continue;
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index eff2a486..ab22ecaf 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -99,6 +99,7 @@ struct exportent {
        unsigned int    e_ttl;
        char *          e_realpath;
        int             e_reexport;
+       int             e_priority;
 };

 struct rmtabent {
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index a6816e60..afc139db 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -106,6 +106,7 @@ static void init_exportent (struct exportent *ee,
int fromkernel)
        ee->e_uuid = NULL;
        ee->e_ttl = default_ttl;
        ee->e_reexport = REEXP_NONE;
+       ee->e_priority = 0;
 }

 struct exportent *
@@ -374,6 +375,9 @@ putexportent(struct exportent *ep)
                                fprintf(fp, "%d,", id[i]);
        }
        fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
+       if (ep->e_priority) {
+               fprintf(fp, ",priority=%d", ep->e_priority);
+       }
        secinfo_show(fp, ep);
        xprtsecinfo_show(fp, ep);
        fprintf(fp, ")\n");
@@ -834,6 +838,14 @@ bad_option:
                                setflags(NFSEXP_FSID, active, ep);

                        saw_reexport = 1;
+               } else if (strncmp(opt, "priority=", 9) == 0) {
+                       char *oe;
+                       ep->e_priority = strtol(opt+9, &oe, 10);
+                       if (opt[9]=='\0' || *oe != '\0') {
+                               xlog(L_ERROR, "%s: %d: bad priority \"%s\"\n",
+                                    flname, flline, opt);
+                               goto bad_option;
+                       }
                } else {
                        xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
                                        flname, flline, opt);
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index b03a047b..5e6a64b6 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -753,6 +753,8 @@ dump(int verbose, int export_format)
                                break;
 #endif
                        }
+                       if (ep->e_priority)
+                               c = dumpopt(c, "priority=%d", ep->e_priority);
                        secinfo_show(stdout, ep);
                        xprtsecinfo_show(stdout, ep);
                        printf("%c\n", (c != '(')? ')' : ' ');
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index c14769e5..8b436ad5 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -100,12 +100,16 @@ entry above) and will match all clients.
 .\".B \-\-public\-root
 .\"option. Multiple specifications of a public root will be ignored.
 .PP
-If a client matches more than one of the specifications above, then
+By default, if a client matches more than one of the specifications above, then
 the first match from the above list order takes precedence - regardless of
 the order they appear on the export line. However, if a client matches
 more than one of the same type of specification (e.g. two netgroups),
 then the first match from the order they appear on the export line takes
 precedence.
+.PP
+The above list order can be overridden/managed via the use of the
+.IR priority=
+export option (see below)
 .SS RPCSEC_GSS security
 You may use the special strings "gss/krb5", "gss/krb5i", or "gss/krb5p"
 to restrict access to clients using rpcsec_gss security.  However, this
@@ -500,6 +504,19 @@ Don't edit or remove the database unless you know
exactly what you're doing.
 is useful when you have used
 .IR auto-fsidnum
 before and don't want further entries stored.
+.TP
+.IR priority= num
+This option allows an export to a client specification to override its default
+mapping order. By default, the precedence order of a match is given in the
+.BR "Machine Name Formats"
+section above. For example, an IP network match will take precedence over
+a wildcard match. To allow the wildcard match to be used instead of the IP
+network match, a
+.IR priority
+of greater than zero is given to the wildcard specification
+
+By default, all exports have a priority of zero. Negative priority settings
+can also be given, which will push the match lower down the precedence order


 .SS User ID Mapping
--
2.40.0

