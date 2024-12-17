Return-Path: <linux-nfs+bounces-8624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126609F4E89
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 15:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A962168F61
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E471F7567;
	Tue, 17 Dec 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRMOcIlw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38721F666B
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447270; cv=none; b=K+AOGaG5iIsMFDIW922nr5q2pCy+r5Yv/NR0a3nkAMXAFaHbcT76YX3E9T1/XoQAw5Fs3onCb11+U1gXsbzHYGFkgDiNFYrudFNJf1kEy+xtvDgiMfuAzy1ZEVLVHDS8zYU2bmi4/WfY070oMIqa9O4e7tE0VXHiLxmegsYyeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447270; c=relaxed/simple;
	bh=doeD0fF/AEgEH9cA5qsqha7rCpXb63R7IaKT4KVWZ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7zCnMdTla4OVT0ydYJS57i/+KojMd4yUSfkWUeksGMMLJDxqKKO/YSQsd6fckxHuCM/gf+weKvZOwkT0E3B4xmQZrR1o5CeXG3W3oRyhr3tOhrs+utnpzTUJ1TBPYKQ0AYvHBwsn4Tjjiez6ApMT8tR+tmmh4DbrxSaMRP3EgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRMOcIlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A83C4CED3;
	Tue, 17 Dec 2024 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447270;
	bh=doeD0fF/AEgEH9cA5qsqha7rCpXb63R7IaKT4KVWZ8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRMOcIlwoFQszWlALjBiEMCU03+cieEGiqjtknft1lkG5xX4mrKL+pzBCiyBRUrFl
	 ekAmdu7nFgjKvcm3MmeGwdIlF4ZPQxaXTyH8zscBr7cMejWkWroJgcT8ovJaNOOm3M
	 UY+zZNvbeax+Nay/lK04qav+86cMAaYSNiJ9Q9C+TUFDaIDBPj2NSoeh9wxBuUdBaq
	 VdD95mJU/y1ejxjElB1WKy5fQlg7cwCHKK4VpS2E93oyJdXGZDrJR70jyD1aQg67iE
	 Mr0XWkl6/sgo5di+nqf1g7yOj80WPn9teOR9IDBwFIsFggG+JXgzPMjws0v8eNz8na
	 u+WtfQdLXHbRw==
From: cel@kernel.org
To: jlayton@kernel.org,
	Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	jur@avtware.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix legacy client tracking initialization
Date: Tue, 17 Dec 2024 09:54:20 -0500
Message-ID: <173444715751.11316.1383495039657508497.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210122554.133412-1-smayhew@redhat.com>
References: <20241210122554.133412-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=534; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=xNU9JnWhwvq4maUc+UeK0zldeNw2HzjmQZK/QiG+2xo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnYZCdLLZk0KN1lRCW1NhIfPhybWsO9X5FNmXLd e9Mr45l6QmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2GQnQAKCRAzarMzb2Z/ l0MLD/4pgp2LJd9EjRF2LH2814vKJVxM0ZN7A4tJkTEi2P+ztmZKjCDD1C7+hPBVkQo1kE1WUYQ 5hRa2JJ9vZXzZwpjE2t5gkr3F5ibAxD+ctp+9/sbJUD1+msvkwzTViQuPEoUg/hstf14Mk5EloF dB+ZbpjTh5K/zzXCaBv2jzBedSv8cJBebHUKHvxio4uKn4OBj6GkkV8DOvfwVF4m5hb3HThWRzz z0vyCa3crXUjlDtaxbQx9pa/jvC3+gV1Cu5LVggQr5zWdpNMNP9a3oDiigCKqUSpLNGZ36RoChF 66RMqDqadYpUzz7SBXqaVhA0RK1aNl9UQTcFFsFL9wHHkeS9qJMg9oU+a84PHkvcHMQuJvjcBns MkJHHvLyM1Qpkoqhtikk6kn0Ni4R8mJAtkZKijHhSd8z88Cw7+vq+gF1BAZciGmmkUeb92h44eQ YVgrHvtWMGa2rh65jhnjAINZoyAxo+qnV8zakE8nGkU1oOEKwCQ7/Zk0X5PQl91RgLXwckFy0/c KhSRkQLFdWQx/pi0EfEo276jAGRle29e9WNPrsa/66y5h6VEWZWZq7nqiVd76gmetHACCwSkWTu cZVoeJnUFlapXe1hyoJDLYcc4GnPCzmNJAgsYeGQjp5W4/Pfv9BgeyFtj2xKfXg8zVc25d4VrdU +RVdgtO
 /Lls02hw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 10 Dec 2024 07:25:54 -0500, Scott Mayhew wrote:
> Get rid of the nfsd4_legacy_tracking_ops->init() call in
> check_for_legacy_methods().  That will be handled in the caller
> (nfsd4_client_tracking_init()).  Otherwise, we'll wind up calling
> nfsd4_legacy_tracking_ops->init() twice, and the second time we'll
> trigger the BUG_ON() in nfsd4_init_recdir().
> 
> 
> [...]

Applied to nfsd-testing for v6.14, thanks!

[1/1] nfsd: fix legacy client tracking initialization
      (no commit info)

--
Chuck Lever

