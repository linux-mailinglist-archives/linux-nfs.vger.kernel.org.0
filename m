Return-Path: <linux-nfs+bounces-6325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C597082F
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E91F20FB4
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165216FF37;
	Sun,  8 Sep 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="C496tCeZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A314D2B1
	for <linux-nfs@vger.kernel.org>; Sun,  8 Sep 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806091; cv=none; b=UWZm+m9MbytCnJoQM81EbO6vPO4mx1pDzhBozcCGL2h2UPqF5BWkCzrBVSJHsTdvueYnFkn8dmSBSayr1pYZo9ZYQcgaRgezA70hU9dSXcUlgss1gvRHptBstapNWkn4FyBNLY1N3mVop7suir07YFHjZjH9LB0hpyRMCuNQdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806091; c=relaxed/simple;
	bh=R7PCAIyT/xt3W2h/p9slnNuUPGqqHMyfTfCqpfJvZq4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OavezerSt87pgbOzpDenYMKr7hsdNfk3TYp22Q7A/+nRP02BM6ax4ZrlYwpH/SdjVfxYGkID42OPqzlraf7ozgXA88e5rya8iaRapR4TcGOsxqfOtSna0tCcgFNqTAzrw/W3R7I3unjgP1FYj/QNAyfTmNoVA8wtZB1HJksbQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=C496tCeZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso48338911fa.2
        for <linux-nfs@vger.kernel.org>; Sun, 08 Sep 2024 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1725806087; x=1726410887; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2vScN1vxPt/p4ZjPQqv0ayrn93NNFmTc/C7KQqWS5Mg=;
        b=C496tCeZoI+jjBqRhobkszn/x6jv3YQy2DRzVorfYuzCACvHb06jn4cudUh07x1TwP
         MAolddiXlb9DEeASuc+wdOwrNO5OWOAHqwG2xbsJFsLHPnwdHU/B/htD+Fh2SAoTyfS5
         MKfVNX6dXhi9fWPdZXrNkk1DDWXWn4nqZZ/Ia6bDJn6+cjfAVBBeRrJrSK7kr0Q9F/lu
         IDS1CTkg3JWgEKWR0H4K+CcFx/sAwl/FjfYEMLBSCofKmKHyGstHykJzfFD/0Nmfxf08
         yt1UhGZYHqquqfxxLZefPvJIumUoh9WVf7KF8fLyANHG8++c3bLslL81F4pyAn+WCKka
         Mu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725806087; x=1726410887;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vScN1vxPt/p4ZjPQqv0ayrn93NNFmTc/C7KQqWS5Mg=;
        b=djPPGSyfHx/4P/Rk9URxB6YiN9uxafDIdxl/C4Brd8azQJBJgh53HQFjutV6qfrc+9
         5SCXLNve/s4RNTIY77npzAVYUGHgjKGFRvV1s4INQtTQQbURUFgxzgm2KtdaCtuc7BlK
         lC/RITzdefMB2I8i7rVwIf4NyMfSGmrHWRFs5PieKmZ6MAGazvjrm/L4yUpygHhHia6r
         4yvhCO9NdxYjlWSQt2sVR/3hdATw2iS7x0amrXnQvtt68kIZ7CiqqeN3R1V4U4CUUKNk
         pemS/uIuoSmGDNVVPMSwujY7+XCLWoZaW+AjhScN5hR6fJJdNnfXXvN81uvT2uCzYU3C
         At5Q==
X-Gm-Message-State: AOJu0Yx+NZxo1Rsfp6nqmAuggt9gGaokaypjpmC9wg6TlHPdacC7CQ5y
	BrKPG2ePPvWiBl9zCWuOrSLnLm5Lr7HrVyIYWTRI2izCTdWSGDYRilApi5PAvtSisVyKhhBhKx/
	LqZXv8Zmnzy5UmkmDiikx8Zoliq87PUM8YL0JBBnTg1dZa2ARPzY=
X-Google-Smtp-Source: AGHT+IFDxmgUkXIkOZKRgKihCGGAuPtablquTKveOyaD5zWxjDiZdKUwsSh5GaK+KXUrpSiDPZ3gMx9MP+pXGXTpOck=
X-Received: by 2002:a05:651c:150:b0:2f7:54fb:e671 with SMTP id
 38308e7fff4ca-2f75a99e890mr34805721fa.27.1725806085505; Sun, 08 Sep 2024
 07:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roi Azarzar <roi.azarzar@vastdata.com>
Date: Sun, 8 Sep 2024 17:34:34 +0300
Message-ID: <CAF3mN6VbfgBV-o5yiSRn=PHAMO1be7G5H5wYRSsasYJ0Pvwv9w@mail.gmail.com>
Subject: Suggested patch for fixing NFS_CAP_DELEGTIME capability indication in
 the client side
To: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ae973206219c8a55"

--000000000000ae973206219c8a55
Content-Type: text/plain; charset="UTF-8"

Hi,

as discussed with @Jeff Layton sending a suggested patch that aims to
fix NFS_CAP_DELEGTIME capability indication in the client side by
setting it according to FATTR4_OPEN_ARGUMENTS response (and not
according to TIME_DELEG_MODIFY) support as draft-ietf-nfsv4-delstid-02
 suggested.

Thanks,
Roi.

--000000000000ae973206219c8a55
Content-Type: application/octet-stream; 
	name="0001-NFSv4-Set-time-delegation-capability-according-to-op.patch"
Content-Disposition: attachment; 
	filename="0001-NFSv4-Set-time-delegation-capability-according-to-op.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m0toaut30>
X-Attachment-Id: f_m0toaut30

RnJvbSA5MDc2YTQ1YTJiY2U5ZDRmZTk5OGNjYWVlNDVkNTg3MDlmM2ViNjFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAicm9pLmF6YXJ6YXIiIDxyb2kuYXphcnphckB2YXN0ZGF0YS5j
b20+CkRhdGU6IFRodSwgNSBTZXAgMjAyNCAxOToyNzoxNyArMDMwMApTdWJqZWN0OiBbUEFUQ0hd
IE5GU3Y0OiBTZXQgdGltZSBkZWxlZ2F0aW9uIGNhcGFiaWxpdHkgYWNjb3JkaW5nIHRvIG9wZW4K
IHN1cHBvcnRlZCBhcmdzCgpBY2NvcmRpbmcgdG8gZHJhZnQtaWV0Zi1uZnN2NC1kZWxzdGlkLTAy
IHRoZSBzZXJ2ZXIgc2hvdWxkIGluZm9ybSB0aGUgY2xpZW50IHRoYXQgaXQgc3VwcG9ydHMKT1BF
Tl9BUkdTX1NIQVJFX0FDQ0VTU19XQU5UX0RFTEVHX1RJTUVTVEFNUFMgdmlhIEZBVFRSNF9PUEVO
X0FSR1VNRU5UUyBhdHRyaWJ1dGUKdXNpbmcgR0VUQVRUUiBjYWxsLCB3aGljaCBtZWFucyB0aGUg
Y2xpZW50IHNob3VsZCBkZXRlcm1pbmUgdGhlIHNlcnZlciBjYXBhYmlsaXR5IGFjY29yZGluZ2x5
LgotLS0KIGZzL25mcy9uZnM0cHJvYy5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9j
LmMgYi9mcy9uZnMvbmZzNHByb2MuYwppbmRleCBiOGZmYmU1MmJhMTUuLjU5NzU3OWZlNGQ0NiAx
MDA2NDQKLS0tIGEvZnMvbmZzL25mczRwcm9jLmMKKysrIGIvZnMvbmZzL25mczRwcm9jLmMKQEAg
LTM5ODIsOCArMzk4Miw2IEBAIHN0YXRpYyBpbnQgX25mczRfc2VydmVyX2NhcGFiaWxpdGllcyhz
dHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyLCBzdHJ1Y3QgbmZzX2ZoICpmCiAjZW5kaWYKIAkJaWYg
KHJlcy5hdHRyX2JpdG1hc2tbMF0gJiBGQVRUUjRfV09SRDBfRlNfTE9DQVRJT05TKQogCQkJc2Vy
dmVyLT5jYXBzIHw9IE5GU19DQVBfRlNfTE9DQVRJT05TOwotCQlpZiAocmVzLmF0dHJfYml0bWFz
a1syXSAmIEZBVFRSNF9XT1JEMl9USU1FX0RFTEVHX01PRElGWSkKLQkJCXNlcnZlci0+Y2FwcyB8
PSBORlNfQ0FQX0RFTEVHVElNRTsKIAkJaWYgKCEocmVzLmF0dHJfYml0bWFza1swXSAmIEZBVFRS
NF9XT1JEMF9GSUxFSUQpKQogCQkJc2VydmVyLT5mYXR0cl92YWxpZCAmPSB+TkZTX0FUVFJfRkFU
VFJfRklMRUlEOwogCQlpZiAoIShyZXMuYXR0cl9iaXRtYXNrWzFdICYgRkFUVFI0X1dPUkQxX01P
REUpKQpAQCAtNDAwOCw2ICs0MDA2LDEwIEBAIHN0YXRpYyBpbnQgX25mczRfc2VydmVyX2NhcGFi
aWxpdGllcyhzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyLCBzdHJ1Y3QgbmZzX2ZoICpmCiAJCQkJ
c2l6ZW9mKHNlcnZlci0+YXR0cl9iaXRtYXNrKSk7CiAJCXNlcnZlci0+YXR0cl9iaXRtYXNrX25s
WzJdICY9IH5GQVRUUjRfV09SRDJfU0VDVVJJVFlfTEFCRUw7CiAKKworCQlpZiAocmVzLm9wZW5f
Y2Fwcy5vYV9zaGFyZV9hY2Nlc3Nfd2FudFswXSAmCisJCSAgICBORlM0X1NIQVJFX1dBTlRfREVM
RUdfVElNRVNUQU1QUykKKwkJCXNlcnZlci0+Y2FwcyB8PSBORlNfQ0FQX0RFTEVHVElNRTsKIAkJ
aWYgKHJlcy5vcGVuX2NhcHMub2Ffc2hhcmVfYWNjZXNzX3dhbnRbMF0gJgogCQkgICAgTkZTNF9T
SEFSRV9XQU5UX09QRU5fWE9SX0RFTEVHQVRJT04pCiAJCQlzZXJ2ZXItPmNhcHMgfD0gTkZTX0NB
UF9PUEVOX1hPUjsKLS0gCjIuNDIuMAoK
--000000000000ae973206219c8a55--

