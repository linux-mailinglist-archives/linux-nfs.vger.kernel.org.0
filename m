Return-Path: <linux-nfs+bounces-18616-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFk8BCusfGkaOQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18616-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 14:03:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A1BAD9C
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10BB23065433
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA337F749;
	Fri, 30 Jan 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYWwVwOl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FF352C47
	for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777963; cv=pass; b=mvW0XW/QZSreS7RpgAY7F8gvUzONN8ywdwapOy36edV32+Xf0GR7x47TNRRWS7I3WWrkgNxfrIk6ZRokVOXhdNb7nozW9fYZ6+/UbSrjuYjtFasbPIUuQ91lJ1cG/Orgu+dwIU8VvPZbTCfYK3A6bc8By4zDYQOUnvsNbydaDXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777963; c=relaxed/simple;
	bh=xG0HoGtWgtaeO6rMJ6ftZ42hhmA+SOj2D6UatodVRxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EQl5JkIoxmGpbcfGbbNbpZVbkmOA9HvoEVDFmw4Y9tdgCaafRgQ7P10m24uqOd1TNWPAmyrkJ4dKfj0f91dc/8j8x+nBmiHL2eoUjjU8PaCZaRl5Lc8ULErNa8IaNEB4ukUCpsE5RHSrTDt/Nn28LIG5SEORlhTe7HvRu85wFhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYWwVwOl; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso3727246a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 04:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769777960; cv=none;
        d=google.com; s=arc-20240605;
        b=dqRbCG+az2I9nzrB04StZClC1sdHH22KjwQDZJ4nve7DZ0BbPekIRfLzZRGC00YCHw
         fgZgt8yATDt4/ed2ac+cEQo1je9w7tVks9SuajJe5QkkazaJz0B3VKcX89qVObNIXI6b
         bKVQ+pSJVgB+bU6vZsJdlZyoZ4lTCqR+lUh1ip6uKVUiQhqn9fIMTbj7j201DfhpNdQD
         Vp5CW8aPQ3PqNpD8WZumT4Ys/PnvcqDb6Tg/Li8lrif1c9WNl58fQwR8KZ8YH8Xsqlru
         EnGk4gRgcgUeXSr1C921gznLLyidJ0qApCX42+Ck46f0qJEYkX9e/ZwM7eRcD9opuevz
         wNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=/5hVLHdfoH2KEaRhGo53o2eC57XReA1/Lk8YzkL01/8=;
        fh=VPlw6eW/mgLYvQ1ksAncKYnztFRvo6nV4qZ9Xo9aFiw=;
        b=GSeHnvsqKs5Tj9fCme02FbpYOqD/mmkww0qOpeUou2vwDOgDd3QyJbxZg66r7wRvsn
         uPkrC4DUJcV/ZCJWh3YJs765+6zPsEkXG4dMP7ViG4opyk4Q9Zp0TSxvRFIzSlraculf
         u9FOkrIfwUa/pjqI4VjHiedcG06Jo0azspfCV9bP5Ept7cKwRfKIOGVQsWexEB2JGZ7s
         2nQI75yxtzNioGVMrGs+eNrs6qNfNwyx84DccAwqdKb2nB415uE0uTnxYNA2udi8KB9o
         zRnnAEErvNvpUyXx0syjLPe4Puj/XayTpeolQgVfDkfCTjkme7EccnoAZxO5/mgobx8r
         TObA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777960; x=1770382760; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5hVLHdfoH2KEaRhGo53o2eC57XReA1/Lk8YzkL01/8=;
        b=lYWwVwOlgaPWDuDiRwKlFgDXMzdOrGvIXHLY8DKNG1lenuvrI5RvK4G8Qw/jlkBjCW
         TuWUcRkZnTBpUv6AgjdMngTt+a+7mLecXSFWkg6w/ZBldxl5T6FxafK+tYJ64IiW1x9x
         zQwTvmL42+yNz9VkV03ndd5W8ER1d8x644mZfRWDrKU3WzDxkVwWVA9/QHiyENZDIh7Z
         DQszxYhE0zB6XXH+jqYCvT+8cKE063yS+0nep5Wn/bvYXBxuwPtGa69zQ7wYTZ1/fb8g
         Phh6r2HZGMR4/JL/pk16RkMCJ3dFw91M+gHWP6Pe7fWLPa/Es7KGLGg+83Izlope8zSk
         39Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777960; x=1770382760;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5hVLHdfoH2KEaRhGo53o2eC57XReA1/Lk8YzkL01/8=;
        b=EfWSHVWOXNoIvKDsw6XJPyFB35KZaEDQXBRD0Sqo5wj6GleZDPzdDCkpv3eGL6zyGw
         V/mBemLnLEg4ycg2NwOcwLgQctD0tHfm5hsJ4316Cc0kLvgyuRbnrKNFSR/pUXfW4cwm
         NNkndL++zE0/JAvBxNhjlpiAezelbVbpgBQnoSHaZ/hP/q2YN1ZcmaH+IbV9MwiKIPmY
         TM6WSVV3IUw9DA8eSMJMhs5un72ID1/+s2jEsREqhqUYaz7tNcLm1OtslEfvvE0qF3fz
         MBx82WebRemXK5RFWEtUbGFP9rdYBSoRa+VhWWavXtAmW3h+Tw7ZiHPCPDH1V20ayzaw
         6ZgA==
X-Gm-Message-State: AOJu0YzfF9BR/0iyv0oap1+DC2CKOrHXxlLO1tPirmoxQhC6Dp8j48RM
	nEauPMhnZIE8ZLniBXJ3SniSQBgfDkDvUO689wlwTJLFCCn/HsknVMEDkQN5gTGaX/mpTWyZXYz
	SSE3MAs2jtZhioHk/C8sEK7/2Mq2mQ4ElWw==
X-Gm-Gg: AZuq6aLmaxfRCuWaZPt8ORgpF7nZ/EbBfsppAoWviRtQ6zBjlk4gpR8eckvGb8DEZMB
	RYIgisXto07b8ak/97fW0Z3PxIbWHK01BbzCVHh0Cjiy+cccm4kH0d2oYvuXLrNIZdSYA/yHec1
	Hc8hdo2B1bA5WfKhLLnnbLrpUkkRxE2HGyc1rUx3stWGS0K6dSD/VCSUILgjOymFK1VFi4oauaL
	vkM9BqaEzW621oeFJ4uePnydV0wj3jz2gAEjdEHi1TPuAo72/7tQ1/PiAH0PsaUSeCxgQ==
X-Received: by 2002:a17:907:9303:b0:b87:1b2b:32fc with SMTP id
 a640c23a62f3a-b8dff221092mr159144566b.0.1769777959652; Fri, 30 Jan 2026
 04:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769026777.git.bcodding@hammerspace.com> <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
In-Reply-To: <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Fri, 30 Jan 2026 13:58:42 +0100
X-Gm-Features: AZwV_Qg9cHb_cy5s1iZbkKmSD6O6rh8Vs18I0Fb-ECMjeghOuBS5bTI7gCCvHXs
Message-ID: <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
To: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-18616-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 639A1BAD9C
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 22:03, Benjamin Coddington
<bcodding@hammerspace.com> wrote:
>
> NFS clients may bypass restrictive directory permissions by using
> open_by_handle() (or other available OS system call) to guess the
> filehandles for files below that directory.
>
> In order to harden knfsd servers against this attack, create a method to
> sign and verify filehandles using siphash as a MAC (Message Authentication
> Code).  Filehandles that have been signed cannot be tampered with, nor can
> clients reasonably guess correct filehandles and hashes that may exist in
> parts of the filesystem they cannot access due to directory permissions.
>
> Append the 8 byte siphash to encoded filehandles for exports that have set
> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
> clients are verified by comparing the appended hash to the expected hash.
> If the MAC does not match the server responds with NFS error _BADHANDLE.
> If unsigned filehandles are received for an export with "sign_fh" they are
> rejected with NFS error _BADHANDLE.

Random questions:
1. CPU load: Linux NFSv4 servers consume LOTS of CPU time, which has
become a HUGE problem for hosting them on embedded hardware (so no
realistic NFSv4 server performance on an i.mx6 or RISC/V machine). And
this has become much worse in the last two years. Did anyone measure
the impact of this patch series?
2. Do NFS clients require any changes for this?

Lionel

