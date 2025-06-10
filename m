Return-Path: <linux-nfs+bounces-12274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE3AD3DFC
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DBF7A5B30
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C0239E7A;
	Tue, 10 Jun 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucrxu/nq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9124238C23
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570867; cv=none; b=KkFRM2Xz4gca4bzFRQhUbvC5cbwxWzr8b3G1kavAeygWZ+fjJAB1yUKyqi3tKmA8TJEHquGK1409hgbRm/8/ESvjbdZb30wOmYdA7moj4WkhLE4R9oGLjbh0g59IWrAxa1smBu9pBQnNqOV0bxBti9ZvoP+ytCa3E+Wwh0gU25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570867; c=relaxed/simple;
	bh=tbyhVrm+I4N4LnkTGPiGy7aaQQu69eN2tNp6dy4GHXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl5GEijm0Pa7CygPjmvOnIxszm7yeluvvDbohN6BLL2lE9I2OODld6CO0Agk7yOViaRQigaYAQN4Y0p+ahdGQLWux3jDfPi3ya3qB/37SWi1QV8QL7fc93OthpggUvXhxNYytMc5tlWM932Y5Jc6hygPUZTeXNVhMpUjoTdrFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucrxu/nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF63AC4CEED;
	Tue, 10 Jun 2025 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749570866;
	bh=tbyhVrm+I4N4LnkTGPiGy7aaQQu69eN2tNp6dy4GHXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucrxu/nq8inWpaD9EpTJXxJuiwjvTxK5v/IRjO6vURxcaWL6muoYsYClZbXpwaFAQ
	 SAbaMbw6bp0ZkpGoDMUcAnN/cpllkmhTUtiGvq6ac3vQrS+4z7fyN7S0c0178ynxsu
	 aRa0lpm/wPMOvffpcITnFYV8ha/ThgH0DIBgHcltgqsxAi4tAUA8hU9Ml3FcxnENhT
	 s6Wgy+K9vdRzkY9jF2YAyYxR1aXXCaS2b3VbSjYjhZzk5xAEt/CpmJTSPFQ5yGhtEi
	 c1NfnTQ/Shac4W3XKc4Ui6muyKYMLDlJaQvndRX5I+59TgpPQfsmkLXPlw6CzPUxTu
	 iM2f/LFHHo/Bw==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	okorniev@redhat.com,
	tom@talpey.com,
	NeilBrown <neil@brown.name>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH V3 1/1] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
Date: Tue, 10 Jun 2025 11:54:22 -0400
Message-ID: <174957084419.88774.3602483102496053755.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <1749569728-39435-1-git-send-email-dai.ngo@oracle.com>
References: <1749569728-39435-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 10 Jun 2025 08:35:28 -0700, Dai Ngo wrote:
> NFSD: detect mismatch of file handle and delegation stateid in OPEN op
> 
> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
> CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
> must belong to the same file, otherwise return NFS4ERR_INVAL.
> 
> Note that RFC8881, section 8.2.4, mandates the server to return
> NFS4ERR_BAD_STATEID if the selected table entry does not match the
> current filehandle. However returning NFS4ERR_BAD_STATEID in the
> OPEN causes the client to retry the operation and therefor get the
> client into a loop. To avoid this situation we return NFS4ERR_INVAL
> instead.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
      commit: 9fd9dde965d8848b240a47dafe558a1e5f24e9ca

--
Chuck Lever


