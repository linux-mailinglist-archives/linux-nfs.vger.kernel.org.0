Return-Path: <linux-nfs+bounces-192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2D7FECA4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EB91C20A72
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2963F3B2A9;
	Thu, 30 Nov 2023 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HItmCpjA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63810C9
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 02:18:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54bb5ebbb35so717474a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701339482; x=1701944282; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pagUBROBEXza8r8q6jx08G2EC1EZTWb5JhhcZz/zLJw=;
        b=HItmCpjA5AdBnzXcQ4OgF1DMgwDmbWDXiPxvzU32hqvpqR8ogI7zH/4xpzIhdmEhSo
         v+OaiCwM1ZIE3DKd5H7pqIld2kUHUOWxbuYBIrpC/lhAOQNkabGr/pZXVJsIqXTUOGw9
         caLnATfiv8s8qBonZXqSPp8IMqbKqz8JqNvXJHBJAzhDxjBFQKGfn05jXcJr/47HBXDs
         lELkmM6t3gGZTt2f0bnkmeuIuLLjF+e9BxJ8vd8GL9hTSALHU4DEq5IDtuhOhBgJk68y
         u7wgP9tbzrdhXe1APqtiTZjDMcbs2BqB5ZEJ0gVcE699jyklcC2aYXsT4672XMhadSUM
         p1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339482; x=1701944282;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pagUBROBEXza8r8q6jx08G2EC1EZTWb5JhhcZz/zLJw=;
        b=saAfH5Fct9SxJPiwo29ZkA8CZFEcF/bynUKRIKuYLLS0hfTTcmW4VZ2p5/8g56i6/l
         jtBREYTje5DwOmWLIccloi5YG8kuCqHByucRs4zQTQzjv0h1aCy1XdSd84a+t5uF9aPg
         /9dcQxE8hHUogYd2S1Pn1srfE7r+uWp/AtLb8JVUuX0QzHMsKVTzphpjfUQYwWfdznUV
         2T53ud5OWfL9XxGGGpExQsHtjQjp+eaMlvf/qE1AQZQEE8Dgx/wMGMMoR9aa6TpiF0OC
         EwO7gSMnZNJSzwGujXW/idl0UjLcwqFpXxW2gAJY2yAKgAqaWvLPp0sAGNuEuRMqzzpv
         M1Kg==
X-Gm-Message-State: AOJu0YwJw9xyTnQ3Cs6j8LFaSNtbKbZOgYFN/9iiT2u9F3PTvxnVmvFR
	NNNKMp2wjHA6iQEwU6P6jadEZ6Rst2Bf5mjfjSrUPQ19T4Y=
X-Google-Smtp-Source: AGHT+IE53f+AG7PANnXQp8JvmCklTKmZn7Ux19jRLAfKHvCSS87Une2PehszuPjif3Qym54eTHFZqJ8HFgMHasTdBkM=
X-Received: by 2002:a05:6402:94e:b0:540:e588:8243 with SMTP id
 h14-20020a056402094e00b00540e5888243mr12938691edz.20.1701339481889; Thu, 30
 Nov 2023 02:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 30 Nov 2023 11:18:00 +0100
Message-ID: <CALXu0Uc9Q-i4TPVP4LQGfHcbpp-vwSL4a1xEzVuFxqDQwfbUCw@mail.gmail.com>
Subject: NFSv4.2: How to deallocate a range of bytes in a file, aka "punch a hole"?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

Linux has fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, ...)
to punch a hole into a file, i.e. deallocate the blocks given and make
the file a "sparse file".

But how is this implemented on NFSv4.2 COMPOUND level? How does a
NFSv4 compound look like to punch a hole say from position 30000 to
position 35721?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

