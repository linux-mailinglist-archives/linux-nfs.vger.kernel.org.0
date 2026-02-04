Return-Path: <linux-nfs+bounces-18685-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1BdcOxP7gmm6gAMAu9opvQ
	(envelope-from <linux-nfs+bounces-18685-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 08:53:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716AE2D84
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 08:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FA83015D1C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0806224AFA;
	Wed,  4 Feb 2026 07:53:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A219E98D
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191632; cv=none; b=B0q/Y6b7Qwe+NtQCgxSl8p1VO6OnRG1ohOutVj77bdGUTQxNOvJecZFGnqWr7GxRUngXyB0MhKvsCXScO+Qja9jYV8lpKHWRt67mY/M/JxyspgUCxGFYK1A1n8FDwL4MdS1sfpVLs82IsNK2qqQFbicKR0PadWv3CxLfBb9IXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191632; c=relaxed/simple;
	bh=7cZ6HiSRjuEKB5bZIASAJ3Z8DQJZXLetTR4Cvay0McY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFD1isKUXCle03l5eWko5kFzZVornvptq7yan2j8oNK6Id6O7TWCXYsEKfCrxxlUpFxMlfxRn51ewK+b2ygc/wWZqnY/eoGPQvp/CoCZ8y+5wH95st1tM5iAvnxki1GpzJv7Xuo0lRjlCCG48YLGWPZYING3D+P0HjyWoPIH3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56646a34c18so2472689e0c.0
        for <linux-nfs@vger.kernel.org>; Tue, 03 Feb 2026 23:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191631; x=1770796431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUrzN4N8aYs+z308MZb4l8llcH3n7fe5n2tW6I3BKIA=;
        b=GpF0t/ZxxJCan6TyQiOuxyye/86iTuefVQ08kIdj2861kfj0A2Kxf7yQ3CBd6osYFS
         EshgcXiQL0ocbeCQ6bYPvkpMG15f5AxYHB6zKLa8MFCvfICxasoFmuz0gc+XWaRLyDUD
         qoHrPy5UhCy7zKYY90Y68DoWIRqH0OEtXoQ4OTwP84JcwmAmrpiCxLF2BJMl/pXbvbCB
         RCPHqWJ2JIRSotzA9RIPYYSJq6S/FkvzEhJftaD6BfWTXgykdYJzjwHKuDoQPaM6UGqJ
         X6mAxBS+RmaIry9ens3Sg3OCcjCNaGkWBJMlJVakjBZxpNvU4J/YzpJD6qmphnvGmm0w
         aJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbKQ7OdSpXemY+J40kV7kEOulwUFBrvKMAVBG18qTiJMZJOt+7MEuoSFkSHLH6/PC452W9eLMwpBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMPEYGfq0MPwyLbQVF8PuQbUJEZRgx72zF5ianAUxjhvRPvs5
	I1djoK53f/kTPLq44VXR+/ttGkb5OH7T5w1K+A7AiP+kQ5LDLPefL20E2puOjY2OWkA=
X-Gm-Gg: AZuq6aK6eDvrLM1+yoW3S3SnoZynOf9NxL3I/ab3c1QOoHh+LpSLLw0UbefIbO2Jr7P
	NE+7whXGAfY7O5+NzrNcQR96TCj2UTVwG5U76EoFpSk/jV5Ah7LUbgXSs29gDiV4RUGSANFizMA
	EJNxIViajI7KciHdO8bNvDaf3Kr0e65SN5dF7XbFTcpaVmV1Q6VR65ppJZD6F6A9LTTUG1sHxmW
	saJU3xIpQgbCVTlTI/k3XuC1gBVUQ8WWkC+D0/Q+rnrM9cBUXFzWsoFlOa5C2J8dxBNn+QPX+fs
	BWvnHHwjpMaRHXk9sHzcDLx9ZM51qumeQFAI+rBrV2j9YNjiov+1+r3Cl65owAj6T+1z6aqYK06
	RtHalFSen1hA7ygKp1t/ywoBcJ5A9u1ypr0qcXKhgFzCBHQxVy2PupzKdcVINV+4G3QlcxA3WMg
	USYZ6O4dsOo4zddm4zxTZwASXXGREk/AU8toHxQfqkUdvlFZnp/ySP
X-Received: by 2002:a05:6102:3f06:b0:5f5:7721:569c with SMTP id ada2fe7eead31-5f93948bf68mr680403137.4.1770191630909;
        Tue, 03 Feb 2026 23:53:50 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948dfe5a63csm566604241.3.2026.02.03.23.53.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 23:53:50 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56646a34c18so2472683e0c.0
        for <linux-nfs@vger.kernel.org>; Tue, 03 Feb 2026 23:53:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzXJ01K8yPURunwKZvCxgrNlCxZDFE7oPOKe6ZGwbUamzfZfVDpMJOTd1APDl55rXQRWgxpmu5tRE=@vger.kernel.org
X-Received: by 2002:a05:6122:6595:b0:55b:305b:4e2e with SMTP id
 71dfb90a1353d-566e8153055mr741014e0c.21.1770191630187; Tue, 03 Feb 2026
 23:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com> <aYKcNds-XsVLRjcC@smile.fi.intel.com>
In-Reply-To: <aYKcNds-XsVLRjcC@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Feb 2026 08:53:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZx=2-y_OSjCkxmXo-3YjGjU0aH89puTcL0rmvw7E-Eg@mail.gmail.com>
X-Gm-Features: AZwV_QjQQaNbz3sSm5Ca5G7xDhKtEIlhGsB9AygKTcUaIrP4KhihNxn7cOIyG98
Message-ID: <CAMuHMdWZx=2-y_OSjCkxmXo-3YjGjU0aH89puTcL0rmvw7E-Eg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,vger.kernel.org,lists.linux.dev,redhat.com,talpey.com,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-18685-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,glider.be:email]
X-Rspamd-Queue-Id: 5716AE2D84
X-Rspamd-Action: no action

Hi Andy,

On Wed, 4 Feb 2026 at 02:11, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Feb 04, 2026 at 02:04:15AM +0100, Andy Shevchenko wrote:
> > Clang compiler is not happy about set but unused variables:
> >
> > .../flexfilelayout/flexfilelayoutdev.c:56:9: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
> > .../flexfilelayout/flexfilelayout.c:1505:6: error: variable 'err' set but not used [-Werror,-Wunused-but-set-variable]
> > .../nfs4proc.c:9244:12: error: variable 'ptr' set but not used [-Werror,-Wunused-but-set-variable]
> >
> > Fix these by forwarding parameters of dprintk() to no_printk().
> > The positive side-effect is a format-string checker enabled even for the cases
> > when dprintk() is no-op.
>
> Note, the alternative fix is to add __maybe_unused all over the place.
> With pros and cons I consider my approach better.

Definitely.  I tried something similar a few years ago[1], but ran into build
errors from the robots, and gave up due to lack of time.

So for the principle:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Ah, my local tree still has the following fix I never sent out, and still
looks suboptimal:

--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -105,9 +105,11 @@ static __be32 nfsd_setuser_and_check_port(struct
svc_rqst *rqstp,
 {
        /* Check if the request originated from a secure port. */
        if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
-               RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
+#ifdef CONFIG_SUNRPC_DEBUG
+               char buf[RPC_MAX_ADDRBUFLEN];
                dprintk("nfsd: request from insecure port %s!\n",
                        svc_print_addr(rqstp, buf, sizeof(buf)));
+#endif
                return nfserr_perm;
        }

[1]  https://lore.kernel.org/a93de2e8afa826745746b00fc5f64e513df5d52f.1697104757.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

