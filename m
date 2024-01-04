Return-Path: <linux-nfs+bounces-921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B0823D6D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 09:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747E71C20E57
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D76420300;
	Thu,  4 Jan 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svario.it header.i=@svario.it header.b="pshk2She"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A720307
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svario.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svario.it
Received: from [IPV6:2001:b07:2e0:f293:c1e6:15a9:bf82:860f] (unknown [IPv6:2001:b07:2e0:f293:c1e6:15a9:bf82:860f])
	by mail.svario.it (Postfix) with ESMTPSA id 78F47DEE45;
	Thu,  4 Jan 2024 09:22:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1704356538; bh=5qPjp4fXJArpYzMu/0BzwV6iViLuY2cOCRhvsqt4DBM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pshk2SheentnOqko9UAzXM0U4vhikOOlTRKiKyda+PuDULywdKJbPTQY/7MmiMGEJ
	 jgrc7hckGCyVlRHZj9SIEa/6dWUzaS6YA+JNTcxvzeoKQlCVnTLpnViUXiPfHmGkaL
	 fHxpubOkQG1jtsTFhShxC/pZEYD4JLuDErw25TnRVidhTDTJlMIeE8K+Ha0F6EKoKS
	 cKswkjc2t42jD537zOaC8dAbHnZI6NdGH6OcvXs4HLtan/Vt47YRrP36T3fK8FGFMF
	 rNK5cE5F5eHpHBqwDJ8e1rNEYDrVOmiV6kl68kVoCNxQSfGCuAnQR+Qljx/sGakf4p
	 qtcTG8tsmTf/A==
Message-ID: <ee1c393b-ba67-4c42-b792-c50873953566@svario.it>
Date: Thu, 4 Jan 2024 09:22:17 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Typos and documentation fixes
Content-Language: en-US
To: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
References: <20231217145539.1380837-1-gioele@svario.it>
 <309b84e2-4144-4ba4-abf4-f377da5c9ad2@redhat.com>
From: Gioele Barabucci <gioele@svario.it>
In-Reply-To: <309b84e2-4144-4ba4-abf4-f377da5c9ad2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/01/24 01:57, Steve Dickson wrote:
> On 12/17/23 9:55 AM, Gioele Barabucci wrote:
>> Hi,
>>
>> the following three patches fix a few typos detected by Debian's QA tool
>> lintian. The last patch also adds Documentation= options to various
>> service files.
>>
>> Regards,
> First of all thank you for doing this work... But
> the first patch does not apply and there are no
> Signed-off-by: Your name <email@address> on any
> of the patches.

Oops. I'll send a v2, rebased on 2.7.1-rc3, in a few moments.

Regards,

-- 
Gioele Barabucci


