Return-Path: <linux-nfs+bounces-13866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E44B309E2
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 01:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF20B3B90A1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665226AA83;
	Thu, 21 Aug 2025 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOhlvg8s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8122CBD9
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818000; cv=none; b=S98d99pVnhKpLRTucj9LrS9s1aFcZAvGC+vpVODjLca7/S2WjksdAuT1XxhTONUC2xL1KkUJztUmSC3NItJMcfy4TEdMovWxa2fkgzfEipQNkFDOUZXcnDtfCfgeAPem3Q4cjxRNGib05EFXmYBatNmUCOhcjzYDk4vFmV5GKHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818000; c=relaxed/simple;
	bh=4CGmzK6F9iLN3bnAHmfiyDTVIIs3xg3l7bVbpPHbmfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t+9RXK9V6Op343u3u/aq6RUqu9d6zbeHqdyiAabFUPd5MY4lSWT4Yg1qIwgsYqUXW8eeHhKMRHljxDXA0f/x4q35Oq15hg/6qiRh+Wvb92pMLI+jI0iVRpKc6V0YVcqdK6Xo08/uzKR+P1WLkJy+kASxv4aCHRWimfkQc6R+ACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOhlvg8s; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f8f02afaso12866091fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755817997; x=1756422797; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGXB0jtrUzmz3+LdAsA+ZKNg6hSX/RXgqvPSrcFH9S0=;
        b=VOhlvg8sUJQZVPQYKFuXAJHIZVuIjtIO31/LMHHaXWo59zWKFlRjjQWB7Yd5yMiSmy
         xxKJAIo1IUfrUcBMZzPloTX+R1l779MZiFviGa9CEZHUiEHibJylkCkNJbQA+mEm5tR6
         iVjs2uA6ibE56dhb3OSO0QGZIvyMCr3IDi75fjpjiqSIyjXLCSO5C4mib8lx0fp9mMTR
         RPwabgGrkX9+RqY3S4p8XmFpILKy0UGlW3TDwegcRCMXBc0ZUJ9pL1V7pLW5HSS8Unjd
         GQS6JGa3m8UbPkX58vpPLbXPDdzkNjiP71IH2EMngkARGvAvCO5dInsJK7oHJ/6719e8
         CKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817997; x=1756422797;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGXB0jtrUzmz3+LdAsA+ZKNg6hSX/RXgqvPSrcFH9S0=;
        b=El+vTR6dFWkrYzrapl7Ma80mZakYBR7FGCF5/7hbsDk2MFqKGy/26FR82zh7QwsFVq
         Ql9G2DSVzXAuFtufRNC9TyThnP5eARRh9iaZfUpjpwoKnaM6+iSuSFQk81RM+BQQG5Y0
         QuW5+FZTpq6BWYXIJHV2w4Z1uxpih2WKmfJ+ASNRL/Uc/CacjY1iDrIz7ir1lgXmEijw
         Avk04HsdH+2xiH4HNzbSv9Ik+cUn+d6tLpKuREUD5sBQbcHmNM30mNYoPjfogcNyb3cc
         PYkOop7V7wEiFgdcpFGMDn8ubzy+dNht7+vfymVbEiRl5mM0M2ktzUA8rRx4bt7z5yWB
         kSbg==
X-Gm-Message-State: AOJu0Ywr2xfLmIodvVPDBXOYN9X90gY6Bq1OQtLxr1qTsV9foWm4GE1g
	w+cV3lLRrqCm+BrKJ6SAaP1UNloQKiEuD0XwBNm0mvtVYCSy9cfVMFnJ1nh51uAHMWihsVXo282
	VH74xWSp4hvnaR6XNXhwg+iy7QNWT7CPKGQ==
X-Gm-Gg: ASbGnctFTMoAaL2GisJx7e1Q8D11VgE4EGQOxXI7PL+548Z4gMkyZMv8RC3jsCDsfIs
	XHXAiFkY1CsyD+qOmxVPkSviDkSB6ZwoeJbBzE2Mtfa36frnW2Tu6GD4OxezirlyNE6iKs1LAON
	5YFT8YHnWTsV5mm9mg7E2iVEkVDQf1nr3CskEzI7mFIO0IQcI3ESBVchC6Urh5Ue63xUQlg2Ge9
	gSb/tHGnJsMSEBE
X-Google-Smtp-Source: AGHT+IGDRmFSrjQSf4yobrHKNsMaULPOALBFKCgKPnGZKHo07STAByv51WT1DQu3xgPgFKLtfXMAUKqC5bnN5FF6Do8=
X-Received: by 2002:a05:651c:23c8:20b0:332:2d5a:db98 with SMTP id
 38308e7fff4ca-33650e380d2mr1577891fa.12.1755817996817; Thu, 21 Aug 2025
 16:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 22 Aug 2025 01:12:40 +0200
X-Gm-Features: Ac12FXxueIJFC7MUZig9PPls_lUXnaDjnslAdUjJmMMQhybhyCzbXc3DM6M_5Ss
Message-ID: <CAAvCNcD3ncfvMnqeQMzQgE=qAD1JjwLYRHpN4mmGd+rS+czLJg@mail.gmail.com>
Subject: NFS4 "COPY" between exports on the same nfsd server?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

2 questions about NFS4 "COPY":

1. Does the Linux nfsd require a special setup to allow NFS4 "COPY"
between filesystem exports of the same nfsd, or will that "just work"
out of the box?

2. If a NFS4 client does a "COPY" between exports of the same nfsd, is
it sufficient just to have the stateid of src file and dest file?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

