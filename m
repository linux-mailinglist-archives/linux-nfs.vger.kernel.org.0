Return-Path: <linux-nfs+bounces-4253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22766914F80
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C491D1F20FD8
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE41422C3;
	Mon, 24 Jun 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLECuc31"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C75220330;
	Mon, 24 Jun 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237829; cv=none; b=Qhk/FgrtPSKn6aYMt1v0d7EktdTcX7Wk8kRe3qJiu8WHsd8PAhgiM/vtNBx+vHqHN/OfFvBvocFjLy2r0dP4OLqqbIDazEa58HahihuckDFjeymd8eE8IW8t/iHGF3mgMsJmlCu87yci2Ub5+mbf4q0KMwJCixpxQruGmKqc2l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237829; c=relaxed/simple;
	bh=cw6zbc293MdZHDKZhsU4MwSfLSAyulD6cdKbVuCr9ic=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=teqw4kCB8pIjZK/GhYjMo246at6rHCbuHI/GzTTKq3umer29MHBS+Br+fPd0ZpvtknrWa8kXvq+XHjiurBVdY+EHfzJfzms69GdDrLsq87TbiQ1bU4xZiEnhAi3JyS0GFgoWd08pi/wbBegIcsceaypLySO/h2tH/XZvTG+dwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLECuc31; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79767180a15so257141985a.1;
        Mon, 24 Jun 2024 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719237827; x=1719842627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tRXqOoKCMQtByqtH5Ot9WPtr7SGsctCRaNE8KRf/9oM=;
        b=ZLECuc31budP5cOx1iPyAiM3acbPXvmjDSW/JvnwRCmEirrXCTHApLTeBAEWPEzNKy
         MI1kU0r7dy2oq1pP8mBITxSzkx65V6K+2CblcelzcoVD5vkAet/M/nQf8r9WLwNwUW0+
         NvhDpYcfGa94h8NjOtnTNAGLdW9k7pm4a7/y8kwLh8HH2Og2dgB2oNNVYzj1ZiBKhISm
         Z9PuiMM7QDVB+YCWbIce8te8f/fxSbCBj4VVS8lcTNVJ8mfS6hTr+6fyLjeUGh4D6TVi
         ukyDFlEJCZBvWXDWJoPMWur5TrzIiCK/lwqQf7YcRYOyO/Gcfh33vX1rfE2UZgMVRlSU
         rInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237827; x=1719842627;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRXqOoKCMQtByqtH5Ot9WPtr7SGsctCRaNE8KRf/9oM=;
        b=JDQcsF+XdBszGA3djiigt/sWoS2KtKV+9Th2zVzLI6PE3c+pWO8bb6K1VgcdmxLIFy
         J1MHjIdxiR6hQbADs4LK1Jx6d41CUc77AgvKYUTtCWYJB31nv6m4KNokWl2OYOkp6gHw
         Y9QL8rih1Y4rFRUP1qAfmjetVnOCCY1aVAf+zK65HS42j7V1Pvrqwe5/yxk6y6sdObau
         qbI39Er9nFUSBuXVhZwrraCiY+pYHHcuUd1LUKSExvzmVNOaT7BNK9StkpnbqqLDdd+j
         lizXlrjqA2mKLT9Pl58D/euVGltaLW9fWj6uUUijeJVMPxtJbBl+UqbEW1u94IfWZrEZ
         kvRg==
X-Forwarded-Encrypted: i=1; AJvYcCXQGpszk/3Nj+B7nDRP+7DVwvlagqTInVhzSCKAWOs0MeEYIlwpD5U7y4Qrtw0V/o8tFRMYtBjaJNb/AKLzHXdZXJDrns3v4Q/3Z8rr
X-Gm-Message-State: AOJu0YxL9Bro1QR9x4OqbrJPoV5P7hBQZkrs31+XCNh7pJNYcHGHC+gg
	V/HE1xX2cpf42we8cMjggwtKV+yDz+I9C9GAq5fDh+qT66RnjvlEu8PG1ddllK60BToRbzEpcZJ
	AJcYIKAJJES5R72LRSlKjHm1rHLw=
X-Google-Smtp-Source: AGHT+IEdcoVxO1iJxjpGg3jTYzJTgcSXIua8qNrQ7mS+EU2FQUAErqljhrmqVXaLvoKOQJOgOd5Y6nj9inRAE2YuGVM=
X-Received: by 2002:a05:620a:454a:b0:79b:f3a3:9f38 with SMTP id
 af79cd13be357-79bf3a3a13bmr257427185a.20.1719237826730; Mon, 24 Jun 2024
 07:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: liuhzy <liuhzy0329@gmail.com>
Date: Mon, 24 Jun 2024 22:03:42 +0800
Message-ID: <CAHRejUqn_wXsK+N92icbJtFDBzTD=EvwdXdr+CCfVzD9wWd-rA@mail.gmail.com>
Subject: NFS-AIO-doesn-t-require-revert-iterator
To: trondmy <trondmy@kernel.org>, anna <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f29ced061ba33f75"

--000000000000f29ced061ba33f75
Content-Type: multipart/alternative; boundary="000000000000f29cea061ba33f73"

--000000000000f29cea061ba33f73
Content-Type: text/plain; charset="UTF-8"



--000000000000f29cea061ba33f73
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><br></div>

--000000000000f29cea061ba33f73--
--000000000000f29ced061ba33f75
Content-Type: text/plain; charset="US-ASCII"; 
	name="NFS-AIO-doesn-t-require-revert-iterator.patch"
Content-Disposition: attachment; 
	filename="NFS-AIO-doesn-t-require-revert-iterator.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxt1s5bd0>
X-Attachment-Id: f_lxt1s5bd0

RnJvbSA1OGQxYzk3MWIyZDQyODcxNDQxZTg4N2UzZWM0YTVhMjFjODNhYTk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBsaXVoIDxsaXVodWFuMDFAa3lsaW5vcy5jbj4KRGF0ZTogTW9u
LCAyNCBKdW4gMjAyNCAxNzo0OTowOCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIE5GUzogQUlPIGRv
ZXNuJ3QgcmVxdWlyZSByZXZlcnQgaXRlcmF0b3IKCkZvciBBSU8sIG5mc19kaXJlY3Rfd2FpdCBy
ZXR1cm4gLUVJT0NCUVVFVUVEIHdvdWxkIGJlIGV4Y2VwdGVkLgpSZXZlcnQgaXRlciBpcyByZWR1
bmRhbnQuCgpTaWduZWQtb2ZmLWJ5OiBsaXVoIDxsaXVodWFuMDFAa3lsaW5vcy5jbj4KLS0tCiBm
cy9uZnMvZGlyZWN0LmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uZnMvZGlyZWN0LmMgYi9mcy9uZnMv
ZGlyZWN0LmMKaW5kZXggYmIyZjU4M2ViLi4yNjI3NjlkYWUgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9k
aXJlY3QuYworKysgYi9mcy9uZnMvZGlyZWN0LmMKQEAgLTQ3MSw3ICs0NzEsOCBAQCBzc2l6ZV90
IG5mc19maWxlX2RpcmVjdF9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVy
ICppdGVyLAogCQkJcmVxdWVzdGVkIC09IHJlc3VsdDsKIAkJCWlvY2ItPmtpX3BvcyArPSByZXN1
bHQ7CiAJCX0KLQkJaW92X2l0ZXJfcmV2ZXJ0KGl0ZXIsIHJlcXVlc3RlZCk7CisJCWlmIChpc19z
eW5jX2tpb2NiKGlvY2IpKQorCQkJaW92X2l0ZXJfcmV2ZXJ0KGl0ZXIsIHJlcXVlc3RlZCk7CiAJ
fSBlbHNlIHsKIAkJcmVzdWx0ID0gcmVxdWVzdGVkOwogCX0KQEAgLTEwMzAsNyArMTAzMSw4IEBA
IHNzaXplX3QgbmZzX2ZpbGVfZGlyZWN0X3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0
IGlvdl9pdGVyICppdGVyLAogCQkJLyogWFhYOiBzaG91bGQgY2hlY2sgdGhlIGdlbmVyaWNfd3Jp
dGVfc3luYyByZXR2YWwgKi8KIAkJCWdlbmVyaWNfd3JpdGVfc3luYyhpb2NiLCByZXN1bHQpOwog
CQl9Ci0JCWlvdl9pdGVyX3JldmVydChpdGVyLCByZXF1ZXN0ZWQpOworCQlpZiAoaXNfc3luY19r
aW9jYihpb2NiKSkKKwkJCWlvdl9pdGVyX3JldmVydChpdGVyLCByZXF1ZXN0ZWQpOwogCX0gZWxz
ZSB7CiAJCXJlc3VsdCA9IHJlcXVlc3RlZDsKIAl9Ci0tIAoyLjI3LjAKCg==
--000000000000f29ced061ba33f75--

