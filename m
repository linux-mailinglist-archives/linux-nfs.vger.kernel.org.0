Return-Path: <linux-nfs+bounces-9935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1323A2C408
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 14:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB053A9E68
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB71EEA31;
	Fri,  7 Feb 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEgW18cl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6D1EB9E5;
	Fri,  7 Feb 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935916; cv=none; b=rqLVokSDAi9u/JezkxxAF7eOirMFjrvN6fEsZtz+KIcd8zCnmvjxIHNW/ABhwJ/OG0ElihEpffghAmRf3ui4RkYamNSi+klaNlnA5y4Z+UhV1mtH0nW+5WFkK1/SOsshVGk/1N9P9oKQu4EF02C1NxKD/5egnru3Zcmlo6+lqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935916; c=relaxed/simple;
	bh=Ge8e3Dh23MF+aM8z64hrIGIvnI2BFQVXqq+f2Wc6tnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JGZEmKaI/+GhoV0KYCft3nRIfyNJPKKZOIFVluwvQFh0Qp+GpsHxCtWcMJnzKh8UZIVcPFis22V44BYxdOi7G/CGBQtxp0qNP3JDGkbY0y5XC6+71cQEdLLSJIEZnutV0G9qKWGTuZ5ke88x2Yp0m0m5cnARpLzqgNv7BdSVfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEgW18cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A544C4CED1;
	Fri,  7 Feb 2025 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738935916;
	bh=Ge8e3Dh23MF+aM8z64hrIGIvnI2BFQVXqq+f2Wc6tnk=;
	h=From:Subject:Date:To:Cc:From;
	b=VEgW18clLoQxzoiIGz4HJpgweBuhGEo4H9MUTfVM3Y6+PJGejTd67kyvS3w0Tu/QN
	 0xFn2L6xp+95AY1fYRaHpppLDDgSwRdKfbcd+/J8xu3uKU2srtnrdVZW9iCcmI5BWD
	 qQKYLkI4WBCPTqMqnorAMPw/t45jyHHR/6ETEoNsXg+I8ICrB+mm2kTwJf4PahAKwQ
	 k9Mg26h6RzDoMHq2UgwGusWxgjTD56v2weRJc7Iv2gHCN2korzDgkd/FJQgAMD4bhf
	 MCkhTeUU6bykxo90FtTkIQzdIdqqFuN2qjMdlEsA93jOATRG7PDTi1UBb7KJZrmJrh
	 YxDjsLz8P1m+g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/2] nfsd: CB_SEQUENCE error handling fixes and cleanups
Date: Fri, 07 Feb 2025 08:45:02 -0500
Message-Id: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF4OpmcC/3XMQQ7CIBCF4as0rMXAQIu48h7GBaVDSzTUgCGap
 neXdlWjLt9kvn8iCaPHRI7VRCJmn/wYypC7itjBhB6p78omwKBmHAQNLnW0oVzSlimtUBzqzjJ
 S/u8RnX+urfOl7MGnxxhfazrz5fqrkjll1HIulJHOgMHTFWPA236MPVkyGbZUbykUCooxq8EJl
 PKLir9UFFqzBhVHobFpP+g8z2/0Y5CuGQEAAA==
X-Change-ID: 20250123-nfsd-6-14-b0797e385dc0
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ge8e3Dh23MF+aM8z64hrIGIvnI2BFQVXqq+f2Wc6tnk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpg5lQnWuCWpYIdiEjLpjoqXU0X51b0sNESJZ2
 950GJ2tax2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6YOZQAKCRAADmhBGVaC
 FSK0EADIdWTwzSHV1kqYlTkARRFgLUKPwC9EBeCtZZUsEjMXPJbmVQ7geeEJhQSEqvCfleW0py1
 +nA8MykoR0od2zeIeXmUrMUnxufN2mxWt7jxU07U/q2JxEaxvfEr7elK96c3Lawje9XLgDHby9V
 r2+TUQIu6I9HoSrP6Yc2NNeWifsyTJXtcTayd9b+h8QsSajv0XUtTU2Etob04ytDl2DUMOsxBwM
 8e2ZvxeaBv32mGiLIl6k8gKD5IaIBWb6aTjnXDkFRRV9OpoxshLNGR0txTLLnH2kwRFNd5lLKTp
 FcYFquFZOcV+CAJc2wcwMuzrCKSPWOq27GlHgme+n+fTtofGjAtNcQsBybjdyC4el/ePLBAZZcD
 gaff6Q6WdPLdobAaJi1XZb7bPLb0wpFv7ugeokHVLNuu5X+xDOyUPoWaq+5WuuVaN4b1e2rmS8Z
 4Q3c+R/EX9ekJSfoN3wyOZU4AIOp3a0uJ4vAblVwTaf+6eryM5flI2uS3v5y3NxQY5NgP1ZtwNq
 TrifbP++EG+ryy9rJb1gDTbPI3a7rWjQQfN7Jqww6Bm2VKvRIdur5EbJuDl4L74QW1whhTTmOBY
 CBvt5jHasRPy7JUcjqlctdRoNkS2RA/tLX+ciKNLwVapvUKfFe+WgDVJ+YQNbc8osvUKjvQr4Dm
 33hJYFOTWQKh68Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Bruce convinced me that the single-threadedness of the workqueue and the
fact that the RPCs are killed synchronously was enough to ensure that
the session can't disappear out from under a running callback. Given
that, I'm breaking these patches out into a separate series that can
potentially be backported.

I think this rework makes sense, and I've run these against pynfs,
fstests, and nfstest, but I'm not sure how well that stresses the
backchannel error handling. I'd like to put this into linux-next for now
and see if any problems arise.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- Hold back on session refcounting changes for now and just send CB_SEQUENCE
  error handling rework.
- Link to v3: https://lore.kernel.org/r/20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org

Changes in v3:
- rename cb_session_changed to nfsd4_cb_session_changed
- rename restart_callback to requeue_callback, and rename need_restart:
  label to requeue:
- don't increment seq_nr on -ESERVERFAULT
- comment cleanups
- drop client-side rpc patch (will send separately)
- Link to v2: https://lore.kernel.org/r/20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org

Changes in v2:
- make nfsd4_session be RCU-freed
- change code to keep reference to session over callback RPCs
- rework error handling in nfsd4_cb_sequence_done()
- move NFSv4.0 handling out of nfsd4_cb_sequence_done()
- Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org

---
Jeff Layton (2):
      nfsd: overhaul CB_SEQUENCE error handling
      nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()

 fs/nfsd/nfs4callback.c | 107 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 41 deletions(-)
---
base-commit: 50934b1a613cabba2b917879c3e722882b72f628
change-id: 20250123-nfsd-6-14-b0797e385dc0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


