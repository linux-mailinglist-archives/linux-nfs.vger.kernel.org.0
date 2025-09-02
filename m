Return-Path: <linux-nfs+bounces-13971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E7B3FF0D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBBE1B26EEB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084222FD1BF;
	Tue,  2 Sep 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9pE5kZE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA719F461
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814304; cv=none; b=F6CGiLeV0VAgMNsQv3qFxxVN06hlseLet461OvxfSo2u/zPOeJvO93aoCTY8CNVMoAhEtQqMP/hLj3122/xyEAbbavlFyxraVt8IEDJ86J7K4z51SJcwBDOeybK1G9c9Emvm9705/lcqXtHFBSN9EPs8XP+8AMKCdBrN/q+VAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814304; c=relaxed/simple;
	bh=eGZXH+ee3B16Kh5E5kXQw7Pmu7VGKXybXvL6KclRpyI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=EoOX5fz6uNS2ezsByep8QcFQmvNxvm4OOpA0PLLfIW4VAAC7RfDO6a1HdJpsUF+6NlveOE6L+E4g8Nl4L5djwkF9fEmgqivpXB151XGDg9PvjF5CidoC9R8zQEalxVIfby96hGZn8/fUyyIZcIKxg0s6Uhbu55zp4oA7x6l1WE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9pE5kZE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70ddadde2e9so41969066d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814301; x=1757419101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFjBTLOPUw+HN3bSSTkq8CjXUq5fXvf65v4QjXP0LrM=;
        b=E9pE5kZErlNXSize/yISVAduolU6vLviEgYPasQNppAlvdQCt87+xZ32HwkqrR0I66
         XlBGOKHJO3LJxcSKRvPSWtEAQao6IFC4cqIOc45ZHV2iX/vYBKyTuuL1k8qnSHL3e0JS
         SaxdcSxKvFI3PHyefa6RRsbgogqVJnVpjVTB55Zo6jS/RIn3y2aAv8xxeCBJqXuRw91u
         dgQzX5GcYKy5fOpwuEzAsTOCeNE5FF07rA8zkHtpXtL612IQ4QIjBok644W4nvIZoa5p
         suCUdhZDiDUROpjBfX8ZR5AeJ0qc8uFUyJg3WjEcF2QPxkQZdWUltOiXoPpOiuFBe5zo
         53Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814301; x=1757419101;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CFjBTLOPUw+HN3bSSTkq8CjXUq5fXvf65v4QjXP0LrM=;
        b=ojgeMYKNnYenySBWdhGcXq/6SpCics2TDq8CoOPL0jWO/H1+906D8OKXaXUpb1nonC
         xff2s/RXjHWjRVeh6QYUuF9jeFzjx4janNFWgT8SpzpfKU41ur/D1kl+E1g/8iBMRpeV
         zC+/ZgfcIu3yzJzndsLCm0hVg+o691cbvF/t1UK7r3GAOvsqszN7TPD189Nh0NYRnQSA
         vLU3Onkceo7LW7wqaaUnC3/N3fpsMnwQAhimgCG2cigif78quHEBXzttaTrsom6pTHWK
         aKkbRjomKX7MXBdo5tlOCwIt5XLqsKGoRy6C8lzDxcR83YrzmKfmJjEqwLtSq7pOuZeV
         KBBA==
X-Gm-Message-State: AOJu0YxcA7FxKsI82iqRFPqUtXm0WO2rOuIwP5fCBVVuy222rI/nFkIb
	vkUN+2Fgjq/8KsxQtOjdguKlY+g7bO3Ll6KLaitNVGQZ0b/SlH3D2+bJNbMkZQ==
X-Gm-Gg: ASbGncs4GYvzF3bh7B1yxG+Uyy2IquzdprRkXDFFxCtXYDEcjwFaFzXwkXXhgQ5A05G
	TSFSkFlz8kmumTjqHbozzhDbGROliyoUIrYbKa6VaTM+T5o2k3zXhft+52fBuocYRRaHIuCIHa4
	weMx4IJGB9qL0lqCjajiGrUmwUxqVSRELrj3lZ3vLPj0NCwYQE2HLIlKgUyqhi413TcpXLYGpFC
	7J6mFYw+yGylZiDtfoGRMFsJbRQIgNyCDVHoimTgkAz9yVq7T/UQBdkuan4xUUH2t38An1+G2YQ
	J78m8IuART9QOiTsYkM7IiFaAdrMS4xPSn73PQNRhfVGDgHujqVzjFZiXZIq9VVscnIzBsrpCid
	jXbmZXvrxVXF8IQMYQTH15knc3bnsXrCKjIraMlBx
X-Google-Smtp-Source: AGHT+IF/97QdxLuQ+28KBE3fNxN9KsnbphhacxrFSUohmqpe5KizskDEyrkm3T8VNvJiTf2wT7jMVg==
X-Received: by 2002:a05:6214:2624:b0:70d:e11c:553b with SMTP id 6a1803df08f44-70fac898f1emr141138806d6.36.1756814301234;
        Tue, 02 Sep 2025 04:58:21 -0700 (PDT)
Received: from [10.1.16.8] ([104.222.93.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ada84d33sm10712116d6.28.2025.09.02.04.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 04:58:20 -0700 (PDT)
Message-ID: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
Date: Tue, 2 Sep 2025 06:58:19 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org
From: Justin Worrell <jworrell@gmail.com>
Subject: [PATCH] xs_sock_recv_cmsg failing to call xs_sock_process_cmsg
Cc: smayhew@redhat.com, trondmy@hammerspace.com, okorniev@redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg 
type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other 
values not handled.) Based on my reading of the previous commit 
(cc5d5908: sunrpc: fix client side handling of tls alerts), it looks 
like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_ALERT 
(but that other cmsg types should still call xs_sock_process_cmsg). On 
my machine, I was unable to connect (over mtls) to an NFS share hosted 
on FreeBSD. With this patch applied, I am able to mount the share again.

---
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
--- a/net/sunrpc/xprtsock.c	(revision 
b320789d6883cc00ac78ce83bccbfe7ed58afcf0)
+++ b/net/sunrpc/xprtsock.c	(date 1756813457481)
@@ -407,9 +407,9 @@
  	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
  		      alert_kvec.iov_len);
  	ret = sock_recvmsg(sock, &msg, flags);
-	if (ret > 0 &&
-	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
-		iov_iter_revert(&msg.msg_iter, ret);
+	if (ret > 0) {
+		if (tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT)
+			iov_iter_revert(&msg.msg_iter, ret);
  		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
  					   -EAGAIN);
  	}

