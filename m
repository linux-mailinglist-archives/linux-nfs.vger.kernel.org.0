Return-Path: <linux-nfs+bounces-7297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE039A4868
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 22:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B12AB263AD
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E7208984;
	Fri, 18 Oct 2024 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dBCT/sHc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D380208D89
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284274; cv=none; b=LF6VnWPLad3MQcEjtVaUKieyVgm8cRnAJ7poiErfXnL7bUuqpczm/cY98er99Yz8RKLdDyAyRQj7a4ITZJfFqDOGqYNbLrWf53whH9Bh9Dw3O3+IO/bM/OddCZyHBWda2uciX0vE6EeXdxQFElAYfuKzkeUas23byoybeHJO0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284274; c=relaxed/simple;
	bh=1vjpK0mBMXbwO3GQAvUkiEhUpYleSImUq9h0N24vHEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X5WMxIoiF13TMKAJ4GM0s2JLob50XE2UM0kOn5NT5mWAILI7J7haeBOzypa86wpW7H7N3qjWPGn3KkmimL8qEwwJrWCWa9KQ/kV+4ZmakSYLjEwfASSS/ayOgycn853E+gy8nC4iBhTHfYgOE/sFu7UmqpmQAewzCh1JAYW1K8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=dBCT/sHc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb443746b8so29722381fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1729284270; x=1729889070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1vjpK0mBMXbwO3GQAvUkiEhUpYleSImUq9h0N24vHEg=;
        b=dBCT/sHcQz8Bcn8nZ46N1ZvbnGpSVKo1p+CPWFAozwXNP6AbtUuyTPlW0FR4MNlHbF
         BYsyc4hkFvLIBc1vBqnixbrfd0YMshPsey/66JAsmRCK/hBRCAX+xSeAhOaEW4cBRZ2l
         b/hnEJvJImLKnejKmVbK21zAcTjRwF/TY3sIj15vT/7XABoUz3SWAJs6Xh3w4CnYJzAJ
         UeMOFyMYW9NCV8/sV2tAG57P14SJJC7FGhYwPjifkP7+tpuXBolrk9Pg7uJLxI580FHh
         rWlych1+Pcd+OKLBJLmcyoEA18DelL5WkAojE9sWnXolBNKwUyO8+ByOGzbb6m9uY+yM
         +wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729284270; x=1729889070;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vjpK0mBMXbwO3GQAvUkiEhUpYleSImUq9h0N24vHEg=;
        b=PNBlqxIkFfWHvlkAAXo4EJ3ecPWEvbrbA1ugeEG26mqi0gdW8zSCyCOsmVtnsG9E4g
         VzmOrVqtP2qxc4Vthy8+6GTpe+fVDsV+jmg3tLgxGSjNIYppCbhyZNy9wrmDaPwA1g28
         0c6I7Nkm749dQYs6HUtRyq6rrmYr4U6aaTEXqgWG3pw1qnkmAy9tzehDffxk6pKR0fMn
         HdKg3ozxbqZYQk75Os52oC14WhB9vsjMa4TT6+Gl9NDYoDxFwGw7gDrCBx3TInEJndIW
         z7psXF82DklhIHRBjwoNULzRjYleKlkSwUfUjyGeOAjpuq4PPdbJLjUl/wEkfgnJOa+V
         r27Q==
X-Gm-Message-State: AOJu0Yx89j8Xr7zYMtafgTu0Uik5EDwvDeJZ2w5AWIQMz8jV6aWf7RN6
	I715ffCu48hVr3VAib363tscAce5EwbB6vtT1mah6cDrq9tjaTc/wRWFChSkp0fVz1Pk23W+k18
	+QGy4Dd5XJzvlUpfEQc0MowCKgjWOKg==
X-Google-Smtp-Source: AGHT+IF0GTUAQh0NVhOjw5MQQ0W9ABCdmKd59NpnMUY4AcTdYWjo5JYsVqOSGkM8xymCj8dtVpR1AfgCmFgXuKe9Aao=
X-Received: by 2002:a05:651c:504:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2fb82e93013mr23249081fa.4.1729284269794; Fri, 18 Oct 2024
 13:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 18 Oct 2024 16:44:18 -0400
Message-ID: <CAN-5tyGx9vJvS8RMpA+J8GLd29q_ksfuKJ5CoxDRK6azH0BwPw@mail.gmail.com>
Subject: new delegated attribute functionality question
To: Trond Myklebust <trondmy@hammerspace.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Could somebody explain if there is a problem here or this is really
how things are going to be?

Client opens a file for read and gets a delegation.
Something happens on the server to trigger a cb_recall (another client
access, local access, doesn't matter).

Old code:
cb_recall call
cb_recall reply
delegreturn call
delegreturn reply
We are done.

New code:
cb_recall call
cb_recall reply
open call sent with "claim_deleg_cur_fh" ??? why is the client sending this
open reply
delegreturn call
delegreturn reply

Now because the server is invalidating/revoking the delegation state.
what this could end up turning into is (re-writing all step for show)
cb_recall call
cb_recall reply
open call with claim_deleg_cur_fh
open reply with err_revoked or err_bad_stateid
test_stateid call (testing delegation stateid) again why we got the
cb_recall delegation isn't valid obviously
test_stateid reply stating it's revoked
free_stateid call
free_stateid reply
open call with claim_fh
open reply
delegreturn call
delegreturn reply

We went from 2 RPCs to 6 RPCs? That seems rather bad. Is doing open
claim_deleg_cur_fh a bug?

Thank you.

