Return-Path: <linux-nfs+bounces-3001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835668B217C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 14:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0864F1F2170D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091E312AAC5;
	Thu, 25 Apr 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0wsmt/l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE212BE89
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047566; cv=none; b=NNCjuDelTtAQT0sNXT7ny3GvU8e2nlTcf1ZSgKh8tIVk3rLnpVaLctdV+J4NNaEQA0aX1+8JJxFVCrT0U33AuWV6N7dgrIA67tProsZ0ObES1sLEuHhy2XTotm2SoKotP9D9fP8OR1krlf3KAWyt6ZNeS1spBfg+nMMA+eo19Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047566; c=relaxed/simple;
	bh=ltwivhPTI2+aOsMnH+9wjPtGPPtJ8qJs/+zW4UXRbhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Xn5RtCemSzHxVlzjkg+cIfSjM+4X74H169DbWU7rUqh+zKm5/Iguj2GyLtCg9wRIpWA/QH+cvbo93b3l84Grwz+1xYP7NSNEWXq+3uxIVulI78SEAJ6aHwywFtXfFhs0mejFDhlRJa6kwH/koRXgfs97mnAEjGEcoMEbbUeSW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0wsmt/l; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ad7737ae84so497868eaf.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 05:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714047564; x=1714652364; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obdMhYrUMbq19CHKymL34S03U0w37SHCxgJsRpC7HDQ=;
        b=L0wsmt/ltU+O/6QBEYaoznMhi3VQvoK0diCqkshyeELMtIvdgk2n71qmWYqkzHSCDP
         cMk5JY4emU42LkASmCJjd4rCOn+ujN3F6VawxaHK9eUfeA29wGHkktEu4tn1Of1XabwN
         5GJbwDKQSNDOOG/5JxsV38fCqv6/RDYCtmFsotzzKaTcFtxLd5mbYto1dxUyrLOgDJQh
         BtlXkrM8h05nkmQWXuBsaigkzAbPOVJRvWN9mQbWcFor89zku89AeRMu3eIJ94vgFg75
         Edbh51dgvEy6hUph+qtL6xKPBkMW6dELTmBOFacCtVrtADjN4kMkyPWlXrcaofExHGRh
         rXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714047564; x=1714652364;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obdMhYrUMbq19CHKymL34S03U0w37SHCxgJsRpC7HDQ=;
        b=t7OEi/lWHn+jl8mq6hCgnDqSmqYlTmloDzJCtJgg0VzaBi40QLaI8RdgNSuyo5B+qN
         FrrBh+ezqoUp2Q/9umm8PbtoI/OTfrRL56xl0Fkc3UfGQC4JH9hQLUXKsivKe+Astgax
         Jw7WKA0Du7lsy07ll1aJfGh9WfaJyOI+L0qgs26cNxamh2iLC2pygipS5Om8wVPzQiKd
         ehOtC0HbUvigGopwwrUg3gxAW8eeEOA1Npzmq/DudH7n3OoEyR2aepgKJIiyhynbHF+r
         Y8DIs5Yn/X2MkBPXnM/Jp4/W5vz7NtiBgUbUNWNtQyGP+6xOGzXcHc0OKgDe/yQjfrFh
         r3lA==
X-Gm-Message-State: AOJu0Yy5hn1Z8S7bgEZnL6+Y+YcazMY4ksfA0MT/DZmaYJTbHguJbEFw
	NDS1CE+JJPU4h7HnFZe9PvLm609O2ilJ1iDEpYU65G8SvEtuzMjSKADl6+XbQNf5pne+CqppfMN
	gSQMwfIoTdYy43Zx+5ADrbcXKNP1oANqN3Y4=
X-Google-Smtp-Source: AGHT+IFhwwInyxMYAXPFtTSLhDNsznyBWTda+JTE1sEgIurwR6WTt2FCb8pBaithhpArpdW2Cl3AV9OmDSRnQ/rBags=
X-Received: by 2002:a4a:54c2:0:b0:5aa:6a28:27ea with SMTP id
 t185-20020a4a54c2000000b005aa6a2827eamr6118091ooa.6.1714047564029; Thu, 25
 Apr 2024 05:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <662a39f7.BuSJ6zaMPTMaMa7L%james-p@moving-picture.com>
In-Reply-To: <662a39f7.BuSJ6zaMPTMaMa7L%james-p@moving-picture.com>
From: James Pearson <jcpearson@gmail.com>
Date: Thu, 25 Apr 2024 13:19:12 +0100
Message-ID: <CAK3fRr8N4dNz2+K-BgaZAcswbfXrDem6Z9fRtgTDMJa=Y0R8gA@mail.gmail.com>
Subject: Changing the precedence order of client exports in /etc/exports
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Many years ago, I asked on this list if it was possible to change the
precedence order of exports listed in /etc/exports where there is more
than one possible match (see the thread at:
https://marc.info/?l=linux-nfs&m=130565040627856&w=2) - and answer was
'No'

At that time, I used a simple hack to force the precedence order I
required (by modifying the 'MCL' enum order in nfs-utils
support/include/exportfs.h)

However, the issue has come up again for me, so I thought I would see
if I could alter the precedence order by adding an exports 'priority='
option as suggested later in the above thread

I started with the nfs-utils supplied with CentOS 7 (based on 1.3.0) -
and added logic to lookup_export() to check for client specifications
with a higher priority - but this didn't work - so looking for other
places that looped through MCL types, I added similar logic in
nfsd_fh() - which seems to work as I expected (I'm using NFSv3)

However, adding similar logic to the nfs-utils supplied with Rocky 9
(based on 2.5.4) didn't work ...

But comparing the code in nfsd_fh() in v1.3.0 and nfsd_handle_fh() in
v2.5.4, nfsd_fh() in v1.3.0 does the following towards the end of the
function - whereas nfsd_handle_fh() in v2.5.4 doesn't:

        if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
                found = 0;

By adding the above lines at a similar place in nfsd_handle_fh() in
v2.5.4, seems to 'fix' the issue and all works as I expected

I don't fully understand what is going on under the hood with all
this, so no idea if what I've done is 'correct', or if there is a
better way of doing what I'm trying to achieve ?

Below is a patch (made against the latest git nfs-utils) of what I've
done - could anyone let me know if I'm going along the right lines (or
not) ?

(I apologize if the formatting of the patch gets mangled by Gmail)

Thanks

James Pearson

diff --git a/support/export/cache.c b/support/export/cache.c
index 6c0a44a3..e9392d8e 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -54,6 +54,8 @@ enum nfsd_fsid {
        FSID_UUID16_INUM,
 };

+static int cache_export_ent(char *buf, int buflen, char *domain,
struct exportent *exp, char *path);
+
 #undef is_mountpoint
 static int is_mountpoint(const char *path)
 {
@@ -877,6 +879,14 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
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
@@ -910,6 +920,12 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
                goto out;
        }

+       /* adding this here - to make sure priority export changes are
+        * picked up (this used to be in 1.X versions ?)
+        */
+       if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
+               found = 0;
+
        bp = buf; blen = sizeof(buf);
        qword_add(&bp, &blen, dom);
        qword_addint(&bp, &blen, fsidtype);
@@ -1178,6 +1194,12 @@ lookup_export(char *dom, char *path, struct addrinfo *ai)
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
index a6816e60..548063b8 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -374,6 +374,9 @@ putexportent(struct exportent *ep)
                                fprintf(fp, "%d,", id[i]);
        }
        fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
+       if (ep->e_priority) {
+               fprintf(fp, ",priority=%d", ep->e_priority);
+       }
        secinfo_show(fp, ep);
        xprtsecinfo_show(fp, ep);
        fprintf(fp, ")\n");
@@ -834,6 +837,14 @@ bad_option:
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

