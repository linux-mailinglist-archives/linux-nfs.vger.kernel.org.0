Return-Path: <linux-nfs+bounces-10053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4DA32737
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FF81885CBF
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9720D4EB;
	Wed, 12 Feb 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DyIgxvkH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Mm8ZIgA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DyIgxvkH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Mm8ZIgA";
	dkim=neutral (0-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKPHCWWV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE420B7F4
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367265; cv=none; b=rmgHpeSjh5Y6ApAP4ejRIcBrE2uCyliGqk8pl+hy9QADAHp1/xLp9404TJQ6FZaMEhslF0m2ZJrHGAKTQbV+XfilabEO9zMkgrDW1MDEZ5v1g3r9BI8sEWpkzCvssfRqov8VWnZVQnjViInd0zwEUsnRHxojvcRKeDJisruDLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367265; c=relaxed/simple;
	bh=PG79yoo2o5+2QwWLAI/wq836P/11i4j8J4/5R6LWPbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ucb2B7iGpEI8bm7eCulYMSFK4bHITyId8MIoUEwRI66z3wWB0IZphmcPsiyKiE9m9QE3iPpuyJGlBWIL0iNp3nNeNELjKoBdVHVcg6KI5FStD97h20aRSDa8837VVuZ9cfJx5P2W2CTkVBCZ/qLLADV1JvLaKyp6c3lTGjqFInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DyIgxvkH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Mm8ZIgA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DyIgxvkH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Mm8ZIgA; dkim=neutral (0-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKPHCWWV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFC771F443;
	Wed, 12 Feb 2025 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739367261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=LVUGlWOZGhlYxpbZ80tAWtcy/NYLe2rWDilNwHEB8cs=;
	b=DyIgxvkHbtrWa2x7ZVJSKtT8wWWX22LaNuYG9h36flAS6EXBAl6AFXIlLACoFNkFL2AjSS
	+EZPS3ckkDKo4cnbtvKTYd/pzWCEqxxgFepOZ+oK5Al5aFkq4JqiAFRShqcfPgZoAwKBuj
	76Ddsesjt3/xZ/JtHzM5aATLda3ZeDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739367261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=LVUGlWOZGhlYxpbZ80tAWtcy/NYLe2rWDilNwHEB8cs=;
	b=/Mm8ZIgA86bRNa3kRHy0qSDLLi1KO1QjIseUFSO3ucT8+GA17w0l049Hnxzr7FU24kYKP3
	DGbejCIc7V5otOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739367261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=LVUGlWOZGhlYxpbZ80tAWtcy/NYLe2rWDilNwHEB8cs=;
	b=DyIgxvkHbtrWa2x7ZVJSKtT8wWWX22LaNuYG9h36flAS6EXBAl6AFXIlLACoFNkFL2AjSS
	+EZPS3ckkDKo4cnbtvKTYd/pzWCEqxxgFepOZ+oK5Al5aFkq4JqiAFRShqcfPgZoAwKBuj
	76Ddsesjt3/xZ/JtHzM5aATLda3ZeDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739367261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=LVUGlWOZGhlYxpbZ80tAWtcy/NYLe2rWDilNwHEB8cs=;
	b=/Mm8ZIgA86bRNa3kRHy0qSDLLi1KO1QjIseUFSO3ucT8+GA17w0l049Hnxzr7FU24kYKP3
	DGbejCIc7V5otOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FA8213AEF;
	Wed, 12 Feb 2025 13:34:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ISf0JV2jrGe8HgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 13:34:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: tahbertschinger@gmail.com,
	calum.mackay@oracle.com,
	linux-nfs@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>
Subject: [PATCH pynfs] build: convert from deprecated distutils to setuptools
Date: Wed, 12 Feb 2025 14:34:12 +0100
Message-ID: <20250211202432.20356-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211202432.20356-1-tahbertschinger@gmail.com>
References: <20250211202432.20356-1-tahbertschinger@gmail.com>
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52F26562D for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 20:24:34 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fc8f74d397so1071448eaf.3 for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1739305474; x=1739910274; darn=vger.kernel.org; h=content-transfer-encoding:mime-version:message-id:date:subject:cc :to:from:from:to:cc:subject:date:message-id:reply-to; bh=vXetNZ68wDwjE/Fzwp1nNP0C1tEkb42sdEH2esgxuqs=; b=kKPHCWWV+lSAeBUDMUoSE27eY9a07ZnyB9v+nxdf1J9ab0J0lI9vPZZsQsPsBc/1dE wNCDp5Gopon5uhWpoxHcmchCPKwk0rpBlUSIf1muky7AnC8ktccuxbX8hsb3Wwh69jKp 1wYgcTOgzTXPYHMZ2tTY4YzoTqEeJumrpDBvbQaF1Uk9piCarK3B4Hz55pxZuEWoyn1x wkznKo6NslImRWUNdQwNi1GJPimicJ1G/jFspW6y7aT3+sLYY3jwTt410wAYRv6A1DDw 8eajVMrxoku31d09HVVJzMSAA+1eUNiSMT2bYN/a2YAcakarY9RJRkLe0tPouHKZk5DB Duzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1739305474; x=1739910274; h=content-transfer-encoding:mime-version:message-id:date:subject:cc :to:from:x-gm-message-state:from:to:cc:subject:date:message-id :reply-to; bh=vXetNZ68wDwjE/Fzwp1nNP0C1tEkb42sdEH2esgxuqs=; b=dA6hY0XH9SKOZnKq8BIP1TC0GRXJ7e6kx8pUcpHmVxp0hp+2CEKISLTRwHNsLRDxJ/ jXt48Fluc2RvF1PEJOLjqvU4OkQmaPUBrqSWuRatL39zoxVSlUJ+nLfdlL93G4AVU/9S o/8lhOgWLI7lTUvxcYf5Wh4mIhKIcPDUFyHQyCwYXGaTcmObNFL4SnelEvmi7nL1G+oA /50K9xejjXg9sdR92pc3v3frCHXb7qCAYnLQ8MpxalVk2TsGe5C5RFBVBeER/3mqdyyT 1DA/d7wv+6mevxM6iIEbxFSF9mit1ixJPYzwm2nJC8ScnclwxtBWTYIY5I7YRsyEI/8U Cfiw==
X-Forwarded-Encrypted: i=1; AJvYcCVa89UQX19s/Ht7KyojrgBnodkn7IMctAUIPsPTCth9ju7YKuyQgW2N+dHxYYVxZXaSHEISe2LDYOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCjHDQeUrNZCdeCAeAiN1X86FlGfBBAqFATqDqYGpsxcAMU06 p33pinjbaFntlAeBQlZzEHXjmev2aaXckG/lc/AIvsYLZZfWTN2mkH1DOuQS
X-Gm-Gg: ASbGncv64v8pbhwImu8vY1eYIpkf+a1fi9JfmeRs1HEY1L/XlkeuxFHkVoPZJRsDMgn 5P2sgomVOHYPLNLpT6+Dp51nc0Upy8D8Xlji155dWD/5g+xbfkmDtueSnkLbCLyC/VlpUkUhY3f ohO6AldA4HPgiEwKvhSKlD6TEHQfUnOFiMgf3MbuWPD1xD/uo/+K1b5mPZrGNIO7By7n5W3u75B imkFEqPkTsnnkzEz/4VMgnRtQylcwfzZsnB1MXSPVFsMUOFJJMlb4vgARXpWB4onESd2JDj+0le UiM7NrMuZzu8AZrzdqgkduxXQob3+3p1oJQ=
X-Google-Smtp-Source: AGHT+IE14/oIvA626EUBGKS2RZfe/O5Xzv27DT5WOPP/xZQMNy3hirss12cOJryTUQtQeX61p++Bwg==
X-Received: by 2002:a05:6830:25c1:b0:724:ca70:2320 with SMTP id 46e09a7af769-726f1d46819mr475863a34.22.1739305473952; Tue, 11 Feb 2025 12:24:33 -0800 (PST)
Received: from localhost.localdomain ([65.144.169.45]) by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af914464sm3687840a34.7.2025.02.11.12.24.33 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Tue, 11 Feb 2025 12:24:33 -0800 (PST)
X-Mailer: git-send-email 2.48.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.87 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-1.81)[93.87%];
	MID_CONTAINS_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	SUSE_ML_WHITELIST_VGER(-0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nfs@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.87
X-Spam-Flag: NO

From: Thomas Bertschinger <tahbertschinger@gmail.com>

> According to PEP 632 [1], distutils is obsolete and removed after Python
> v3.12. Setuptools is the replacement.

> There is a migration guide at [2] that suggests the following
> replacements:

>     {distutils.core => setuptools}.setup
>     {distutils => setuptools}.command
>     distutils.dep_util => setuptools.modified

> Prior to setuptools v69.0.0 [3], `newer_group` was exposed through
> the now-deprecated `setuptools.dep_util` instead of
> `setuptools.modified`.

> Rather than updating distutils.core.Extension, I remove it as it does
> not appear to be used.

Hi Thomas,

Thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Link: https://peps.python.org/pep-0632/ [1]
> Link: https://setuptools.pypa.io/en/latest/deprecated/distutils-legacy.html [2]
> Link: https://setuptools.pypa.io/en/latest/history.html#v69-0-0 [3]
> Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
> ---
> I'm not deeply familiar with the Python ecosystem, so it'd be good to
> have this patch reviewed by someone who is.

> I needed these changes to get pynfs to build on an Arch linux system
> with Python version 3.13.1.

> I also tested on an AlmaLinux 8.10 system with Python version 3.6.8 and
> setuptools version 59.6.0, and it built succesfully for me there.
> ---
>  nfs4.0/setup.py | 8 ++++++--
>  nfs4.1/setup.py | 4 ++--
>  rpc/setup.py    | 4 ++--
>  setup.py        | 2 +-
>  xdr/setup.py    | 2 +-
>  5 files changed, 12 insertions(+), 8 deletions(-)

> diff --git a/nfs4.0/setup.py b/nfs4.0/setup.py
> index 58349d9..0f8380e 100755
> --- a/nfs4.0/setup.py
> +++ b/nfs4.0/setup.py
> @@ -3,8 +3,12 @@
>  from __future__ import print_function
>  from __future__ import absolute_import
>  import sys
> -from distutils.core import setup, Extension
> -from distutils.dep_util import newer_group
> +from setuptools import setup
> +try:
> +    from setuptools.modified import newer_group
> +except ImportError:
> +    # for older (before v69.0.0) versions of setuptools:
> +    from setuptools.dep_util import newer_group
>  import os
>  import glob
>  try:
> diff --git a/nfs4.1/setup.py b/nfs4.1/setup.py
> index e13170e..bfadea1 100644
> --- a/nfs4.1/setup.py
> +++ b/nfs4.1/setup.py
> @@ -1,5 +1,5 @@

> -from distutils.core import setup
> +from setuptools import setup

>  DESCRIPTION = """
>  nfs4
> @@ -8,7 +8,7 @@ nfs4
>  Add stuff here.
>  """

> -from distutils.command.build_py import build_py as _build_py
> +from setuptools.command.build_py import build_py as _build_py
>  import os
>  from glob import glob
>  try:
> diff --git a/rpc/setup.py b/rpc/setup.py
> index 99dad5a..922838f 100644
> --- a/rpc/setup.py
> +++ b/rpc/setup.py
> @@ -1,5 +1,5 @@

> -from distutils.core import setup
> +from setuptools import setup

>  DESCRIPTION = """
>  rpc
> @@ -8,7 +8,7 @@ rpc
>  Add stuff here.
>  """

> -from distutils.command.build_py import build_py as _build_py
> +from setuptools.command.build_py import build_py as _build_py
>  import os
>  from glob import glob
>  try:
> diff --git a/setup.py b/setup.py
> index 83dc6b5..203514d 100755
> --- a/setup.py
> +++ b/setup.py
> @@ -2,7 +2,7 @@

>  from __future__ import print_function

> -from distutils.core import setup
> +from setuptools import setup

>  import sys
>  import os
> diff --git a/xdr/setup.py b/xdr/setup.py
> index 3acb8a2..3778abb 100644
> --- a/xdr/setup.py
> +++ b/xdr/setup.py
> @@ -1,6 +1,6 @@
>  #!/usr/bin/env python3

> -from distutils.core import setup
> +from setuptools import setup

>  DESCRIPTION = """
>  xdrgen

