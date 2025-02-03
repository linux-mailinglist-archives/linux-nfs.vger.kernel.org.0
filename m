Return-Path: <linux-nfs+bounces-9863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78EA25D09
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984AE18846FC
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090CB209677;
	Mon,  3 Feb 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqYah7xD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B0205E23;
	Mon,  3 Feb 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593179; cv=none; b=YY451bXs4X0vV/4kQvzrDfnVqLjdkZskoHmTJWpKsBa+g/3ulE/l6T09jbJUsJeyi/5T4I02uknLCb/91Y8VnA9/RPLl8JxJTS3rT2XIVteBRegb3UDqlBJ44yn0a2BCZU18KuX82b+dItzwrHeCgoeJpRz5t9M9ZlouW3DwQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593179; c=relaxed/simple;
	bh=hQzDsRGxIgrgFjHvxKVHxZz4x/eIClNeq2+A29Q5eUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAfi8lf8oJkSxTafWyIJvCTldpLVhmn10ZDY24wtUSigTpfAscXJDr8mIOny9CwEu2GIHJpNjf3yHaL3rO69ys3NFp1wnKhbPxeMVZh/GYEdaeBwkf2s5oM6UTj56TC3+NpIlt2DRImXiDEeKqEST+BGOtqasJpoBXBAU2GT1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqYah7xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB1CC4CED2;
	Mon,  3 Feb 2025 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738593179;
	bh=hQzDsRGxIgrgFjHvxKVHxZz4x/eIClNeq2+A29Q5eUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqYah7xDjz0QSpiY2jxdAnXoyvVwYjx/BDHEw5VouLCpFVq+RgY5Pe8JTEk6kCfYK
	 YDpafWyrwM5tG8gzm0nXrhA7XjOwvEEYHE7MUsChvR4DFl3YV/JbQuo7WaXsVlTc2F
	 YOKbt4Z1MquBvFXzLXTaQoYjxi5ZyNqg+Va/DyiXIiXRMau0G9Ny428+F/DwT+7y9F
	 b4r7m35KH3egoOqd0kp6ecuB5x4ZR6f3o9deZN65r811msv18/3nOnWeQHYQIYi4/G
	 t7qm3qh9AY6q9izaBGytw4LV/+ZZR8xUwOnlfGEc0aokoo1/63SfsjpBDT7dsvE9cY
	 s+gsowx4Bquvw==
From: cel@kernel.org
To: trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux@treblig.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Remove unused make_checksum
Date: Mon,  3 Feb 2025 09:32:54 -0500
Message-ID: <173859315998.67907.4533690960310279323.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250203020743.280722-1-linux@treblig.org>
References: <20250203020743.280722-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 03 Feb 2025 02:07:43 +0000, linux@treblig.org wrote:
> Commit ec596aaf9b48 ("SUNRPC: Remove code behind
> CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED") was the last user of the
> make_checksum() function.
> 
> Remove it.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] SUNRPC: Remove unused make_checksum
      commit: f168d32d0fd2dae44bb438ed6c22d9ab7d9106f7

--
Chuck Lever


