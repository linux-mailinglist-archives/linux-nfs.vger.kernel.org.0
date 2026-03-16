Return-Path: <linux-nfs+bounces-20180-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OKQFra2t2mMUgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20180-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 08:52:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6FE295D80
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 08:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545F930125F1
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A6320A0E;
	Mon, 16 Mar 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPoSU5LZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18365CDF1
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647533; cv=pass; b=Wka/ysgKuIk/XxFXYrkoxRJjuginHXhgjpIBtUqTViuBpPFlGpe8o5kV2k4KaSssQ4CYj0ct+YV7FA3zFQaF95sTgkhLQwDTv+JLqTjBsHWjW6vB4HGEDRiuXI3QOdOuWE3X78+DzyV65W8YlEDEY548darCxqdRflifEp+PgxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647533; c=relaxed/simple;
	bh=rosDsX1VTvseFwaNm9bN9Ecgbh7RuKwb9Kmcy8Lg46Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LcmNjBEbuYeKP/k9N9B2tPV0J7z9FaLs7TFuGLW30R6x9q6W+BGd3w5Z1fDVg3TlhGU5DELkCpGIkrGwBxXDkgEU60qgegR/WUZ+NXYrfebslf0rUa9Bz6guAKBqgn+IwPHKiDXWKk4FLxTXeQXSmcnD5HVb+yfp4xIqaHtYP6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPoSU5LZ; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45f053b7b90so2841812b6e.0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 00:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773647531; cv=none;
        d=google.com; s=arc-20240605;
        b=R3Of5kqC0n/iv+Lu/I7N6j6X+9amA/SyVCy4lrOEGEn2ahU4qqTraM3HrVIH5UJjNC
         sn7Cy62l3Ue8gLnNQXX2edtxJA4ZIfqLgt8xOzSzcFLYb7Caei5GRYl7s1HLyVtTMUyS
         kvL7xGHR8ZYIcxaF3xe/1csiewZAbonX47UhajsH8gxbTZ3G+ZWXpABqSxQGVjfuusL3
         vjv4gDriHZzo+L8EH+biuU5ehWPD/b+GRON/Le6CBnK4NudPqzHCgqrsQ6b5t3R3bNgB
         FZWgIozS9XbZV/IaO9hiAzrIsb8f2fodlz0Eddkvuc2Dqp0ox1X1GyxtjKYk26yX0TPy
         aCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2TAIXGPWSXqXXsnfUyH7zAjZ/EfBvB3ycO+qj6F+A3s=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=R8cNFFYLR8YgKaIf/TZh2IzfZLEhWa/7eHAAqW1omk30UadYCcDdvxYeqFNwoNqhco
         GpI+F10P42592aEnGD/0OW1grvBYkGm7cA5RAfCHFMqozao9Jcv/4CkLOxOfu4CZpJ3/
         EVA5jwUsg1M/bqyezozxGXsmC6kjBLlAJgkj8SVCp4lJFeOa8pOlCO7bPkcyyvz3WI74
         rs1B2j2l/K8E7Ox3GNx24obmvujLV9bNrltbPfcOMXwgets9zQwmHv5jOndeiLNYYtzV
         vw0ytkic8v9jJcz5UPdD62Mrnbaqv6coKiM4HueFlqOuEb6GjwmIwGg1DAPZzuw95us+
         a+1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773647531; x=1774252331; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TAIXGPWSXqXXsnfUyH7zAjZ/EfBvB3ycO+qj6F+A3s=;
        b=OPoSU5LZJcjNI/sysucTnF7qUz/f52P+1zceWtCEaBaDdKwTMkvlio2QOBiZwuDuWq
         ZRpDs14JrrdLBdabUR6pYAfHJ1mUkK3kbvLWEvVybMws9Zd5oWYpTwsn9qrdI++uerg3
         NqamLdKphyGdwjK1nS7d8SC1ofi2EuqJrI1qmfXUOd7VQpvUPnesnFp5chd4gsPO32xQ
         PQNt+EytmiAkhiJr/rbWj9zPd+yJIpX2ogKJuqqPh4SyFE3t3M3Ma2T/GDMUMRoZZC1S
         ahO5Zwe9zFXdRuG7ZymDf65cuf+boCwlgZBe1Xgud6NHRBjdNQizXk0UC9KDGGc02ope
         kkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773647531; x=1774252331;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TAIXGPWSXqXXsnfUyH7zAjZ/EfBvB3ycO+qj6F+A3s=;
        b=m1irelIKqM+pZOj8DVig3qAyH5GKnhDLw/F4wRcOJMRS0zUixLblCUR2gCRJ6aaHTe
         HUuXw3fIYrT0qGV+0i7+MMCN1781vYizvWpaeXcbIyI7LLeEShcRAsar7nWqKFiHu8dv
         4zoBkwn+yThwqPLVNwHEnrDL3x9NRPRhMIOcL7VdFHkZB05mevi0HhFhQu6jINxgmnx1
         zMvVdMEYgOwE/AWUhkobI012WZ9nIFpXSZVS04KkB+xrK4zM5/8lmptux1E/fVuFs8O3
         B+KAo0UN0n2sHBX8es4YtpDnsCl412MCGyV2TS6DrUK9aVYG80/ZNuescfsawif8NNxt
         IZrQ==
X-Gm-Message-State: AOJu0Yz6hIKjRcdROuHQNnDmb4+oIEoDJmqRg856eeQPeKNJXYbHlWF5
	W1Wo3H931/4FmK0RwQxfE7fhsQL2LEU+YfLcfVCx9Z/Q0CnZe7CxNlSm5n+DXImlQEgGvTBbxtV
	U0T/+jC5+H7JS0PYM9zL2nEAUp8a7SxDlJA==
X-Gm-Gg: ATEYQzxVCAG5MfurU9bnwmTMlkIm5PnHmJNl7yxG2bdjXwDAZwR7YY8CsxpJLIoD0XN
	fzzbxqUU6WM0J072uedjHdxcCyg7HsOq+n7W+Uqx23DbGTjUr2MYQVN0ZVy/7WM7FyOy/UoTBWY
	m2aNx4X2ruOMCwyFom49njMlmko/9i/y/NeSzJx/F0oXx/qPx/QctJQejwFZvSP3oRmM6JQCpWl
	h1Qfe/Sx2Dzwyv4AMQrcLrGlhQ5O4yad59uQ1NdF0EQ2h04lMjMnfWVXH7J0NMYlWUFKg4r+SMc
	ItcUEgtRB3KN6ofd
X-Received: by 2002:a05:6820:62a:b0:67a:47b:5a1a with SMTP id
 006d021491bc7-67bdaa7c9f5mr9513866eaf.65.1773647531150; Mon, 16 Mar 2026
 00:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 16 Mar 2026 08:51:00 +0100
X-Gm-Features: AaiRm50CuFla0EzKKgvO6n4x4EdR1CbFWaMt3Bm2bvRfR9KTqw9wsbu7jPLm5uM
Message-ID: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
Subject: Increase default NFSv4 server size "max_block_size" to 4MB
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-20180-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF6FE295D80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Good morning!

As debated a while ago, can the default NFSv4 server size for
"max_block_size" be increased to 4MB, please?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

