Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2AE5273
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2019 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfJYRjl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Oct 2019 13:39:41 -0400
Received: from mail-vk1-f177.google.com ([209.85.221.177]:44379 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731004AbfJYRjl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Oct 2019 13:39:41 -0400
Received: by mail-vk1-f177.google.com with SMTP id o198so655055vko.11
        for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2019 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=YEOLcy5b6kYW5YNkh0AOlJMO1mXAHolUt9McDuRsU8k=;
        b=KGQdFKlqeXwnt1OaE8lB8ASRFCqUR8r+87pDZd8a7ynJVrhlqUCMsx0iwZaodjjbIc
         l2poVPYyp5O65oxJ4S4r4X3DASzJ7gjxevwTXY9lo+sosbRvoKic+5OVKeGES0k6/DDy
         fLKwLEsCfGCetOyVwkzfEdErKXEBTp8BajLOOSIRsRWXwUa5gVdliNre2a0f4Ac/pLbj
         BZGRLhwobZwdKlnfM3nTvOanlp2JyPKPhgjqPS82NK3a2tezXKcSu1DUYz0E8mzys9ap
         7J79huQxOOpspTI5BC2rEzQxP+mEIfDMp8Esb+dG2Du97H7wPOAxMj+13lR1dxOOrGfI
         Z61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YEOLcy5b6kYW5YNkh0AOlJMO1mXAHolUt9McDuRsU8k=;
        b=jRfmPX96QXyeZc7luLWiya2AGqyzD8KRaB8hRGUP/eQo4345cEYU3froU71Rv/n0/+
         pgWyKEOD3k1/LfLLBJHyD5CvVBLl0zCMvRR8sKMLpwZ/jhKZ+CjgO67y+5VHbyuDa2JQ
         qI96iV/l/3zQ8DJkAD+/CAHShSnUzEdhy/KzYGg0VqHxOHoIm3ytgBERaWtsju2sTeGK
         8dgNcd7rQ8V7UKJimc9J1MVa1tK7bhCR4cH2r3do8maw3ntaRrFnMI+6IJSsFKa4OhVG
         Zi0ZT3gZayhZKXbeoATyu4+Mr3JUpBuj5uCIQSR+JewBN3NiN19rt9jE5wCIWVxwthEo
         4V6w==
X-Gm-Message-State: APjAAAWbZNoFg+ypEpljdJmOz8tZzK2NSL2InuQX10/IuD4vN+ZgcTLG
        7CT+7P1AUzaU/YYJz7RqO7+2gKH01hoStqsj9ynRAQ==
X-Google-Smtp-Source: APXvYqzW0UhCuvW5zmgGsRnzpshH6Dq/8xkU1QudgOolo0FLMzizZ+K7Zp7UM6LtFYEy0SuprTonz0PdxEaXjkcsF0s=
X-Received: by 2002:a1f:4e45:: with SMTP id c66mr2773244vkb.72.1572025178038;
 Fri, 25 Oct 2019 10:39:38 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 25 Oct 2019 13:39:26 -0400
Message-ID: <CAN-5tyE1Tuk5XuZJ-ZaexHrRFaiVAik8osPeW1Q2bkTpL_m5rg@mail.gmail.com>
Subject: nfsv4.1 state recovery
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

Is it correct that during reboot recovery the linux client ignores the
fact that the server that the client previously had state with can
present a different server major id after the reboot. The linux client
proceeds to recovering state.

Thank you.
