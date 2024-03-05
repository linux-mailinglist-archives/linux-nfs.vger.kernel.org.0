Return-Path: <linux-nfs+bounces-2206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C387188E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 09:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9191C20EAF
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1C4CB58;
	Tue,  5 Mar 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksqgpo7V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9A2745C
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628588; cv=none; b=OJ7IpCmpMXtZhUuOenvYmNFdynla4BHDXA0Vc9FwDGqRMx1w5fyGu2W9RI/B0WxBFDIkg6QDWrM4FKWm7oByYwS8s6P9JKUvRSIPCkwSIi3aO22/yPDdCHRgkkrJ2dZOlmSfgm690Af80FUnZGzFvfjZ/UTWLm25lPyb0ILGnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628588; c=relaxed/simple;
	bh=U/ZL9lynBEk1Mv7Pi3slpWsW7n10cu4KwVND4lGhLhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZbvZccL/RyxgHweWbQ9L39tJcecTiakfC6cYbSb6x+mRYT70skfMn7wVUDUcMJoD1fN6VtgEkjN5kYKD2Fgbe3i3VL0Dt++3tmvgLMjt1TJkU0adCYcI4pcS272dpnDUpkFcWMRxw06+SaHW5qqal9ZXU8TNoXPSyqaIvDzLuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksqgpo7V; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7890875a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 05 Mar 2024 00:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709628585; x=1710233385; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AftuuQaDTKEqmo9pc4NdWlgn8uQRfxWITGOTQAHvk6U=;
        b=ksqgpo7VA9oWPSjfPoOjRlyk0FG6p+zqTGYe0fSldwDM+oYCPCvTn34/u+pRzB972L
         9QQHquz4b+uNq5/bw5Bmkg4sj6jRgAglP74trBH/vZAhaT/9dLnZzoHCkqH8AJr1QdV4
         lCY+F7ZGxEiaekQGvPMxbb+1xAYsBp8htAsakVmHnDnJCpcDfzPjZ7SZN5azTk8g15TC
         BUXXTX7hs74DUmiVA/zLJirlpivK5vwhgoPYqtoNGPHVznBhFKbUz7Qo35990NKes0mD
         nwtWuuD0Lq4zSoiNAZWQwhbcXKYreypnQNO5Z3Mon7F4LnK+D+Xf42DsB6kN/tVrgNZC
         jGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628585; x=1710233385;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AftuuQaDTKEqmo9pc4NdWlgn8uQRfxWITGOTQAHvk6U=;
        b=u7Bjaay6ioZ/F9EsbRnBygJcCmkKF5hDR/6rbYjfvKwHkco8QlQq+/HVLWv7xjt3Wu
         pM7tIpzGuuzzo2EyMxv/fG89fvuz3ed5JbgXvfiOxx3HuqOw54Tn2xZ3/3p2DxeKKUh4
         Z9FnWMdlPqATVg52egBpTBteiXnpRYqpzKHGYW+2PwqYaev2MI00eSl3kzAzSkVeh/H/
         ObMa5kLxot7vDZWUexYACgIuw0YiLJHXcjaf8AYWq5dDJdQyQsO7EztXAEerZWnNbnXd
         zg+h+BS1aPqw/vQbq5QVPrJ4tSb3TkFc/xYwixcOtJzcAjHHJCGz/y28hY3fjj+SnQA5
         EGkA==
X-Gm-Message-State: AOJu0YxMNWjdY5yfIsDRqwrv3pkS/bvXmrkJncdgesg1tV5iI7hwpp/F
	73Qj4/si1VQQBkYtwuZLGByLwHmNce9/wGKrYa+wJdxOUjc4/Isu9h3wKMb1XpvAUPz3tgNQ4KK
	wGzcPONMhHvqF/W16S5PEsNHHwIAEeUei
X-Google-Smtp-Source: AGHT+IHh6Uc138BctGoi9vEU+pOkboc2Q08L7b+9YtI93gZMksOJgviKBw+1Bnw8yQiyvwlfP9AjWQ1dBTffKB/Mda0=
X-Received: by 2002:a05:6402:3584:b0:566:f66d:bd38 with SMTP id
 y4-20020a056402358400b00566f66dbd38mr7088866edc.25.1709628584858; Tue, 05 Mar
 2024 00:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 5 Mar 2024 09:49:08 +0100
Message-ID: <CALXu0UeJ-s4hOmjOa=SndBx15a1VmEXmGcdhhbouMrSPTMni9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number
 of delegations reaches its limit
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Mar 2024 at 23:23, Dai Ngo <dai.ngo@oracle.com> wrote:
>
> The NFS server should ask clients to voluntarily return unused
> delegations when the number of granted delegations reaches the
> max_delegations. This is so that the server can continue to
> grant delegations for new requests.

What is this limit max_delegations? Where is it set, and where can an
admin alter it at runtime?

Are you aware that for example the msnfs41client Windows NFSv4.1
driver easily uses a few hundred delegations, as required by the
highly multithreaded nature (i.e. every Win32 syscall is async) of the
Windows kernel?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

