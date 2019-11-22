Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F084810760B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 17:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVQyx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 11:54:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39479 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVQyw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 11:54:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so6318618wrt.6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2019 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lD+0drMnoChi/UwuTNq2JDlFciVuyTOxbCMAfn5roM=;
        b=AQjgmsKshPrDaYjCsDtF+Im/F0Judyols2j/Z5WZTo98YToMZndY1J/G9lvh0izHxq
         cs3pukXTw9jJHj5Rd9+b4vvZ+cZoR+3N3xhIFBweR2Q0l4hZKQN177bCPUwVdpaebbEq
         cF7SDLkvY8FSsAWo4L+EeMg5MOhXj8tqeK0xV+u5veUDsDxV2PCghNJu4wqs98EzrERc
         E8V+hxdsFQgm5SarrEYE0KwmeI2Og8WuLc+rt3pcCsxNQ2a7zEOByjuMMdwYphqarZwN
         Ub0s50kk8Tv20Ampw/ah2hC9WHzcgG101nRyVgHWQtKyhWn/E3ovCJc6Q33EJAprckBj
         /4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lD+0drMnoChi/UwuTNq2JDlFciVuyTOxbCMAfn5roM=;
        b=oIKc92MtOnx4Zq1/1yyhD5deTLG9V3RvEihvT9a/5UWNxDfPlOzyGiQpvWLr1IOv7n
         PGzwW1rDEmBgaxbK42w07iRqywWmCMrN+koXpdCTo8fSWj9ehmNh/BpTtVioPTWOfhLr
         yMvh187GqOv8zJN3xTWEOAuDST9s2i62pWWNIG1ognc41Fa+roIWuvDcK+tuZKDx5Ymw
         rDKxT5LNQ4Pi5RSYCxfqYW0uf8baCiw1IGkB9NfR1KlW8lZROfjym1RrgtNTt2XYgi42
         Au4eE/DJO+Dt8578S4eBhrkmEG/kNBcXgKQlVZYoG9NTZ0TicTlRVJE6uXuzNH75g3Qe
         D/4w==
X-Gm-Message-State: APjAAAXrskGn23dE32QL22ePq1D76DbTdxxeg67lA8DR5gROBvVVbLZf
        Hh64zTUvxVWFslxlkNQX/l44+qBv
X-Google-Smtp-Source: APXvYqy+4sHqY14sG1U89Ae/rryjhZra2i+rnxgf84NbDPV/qI8RUjpISC3uHG0oMIfaqXkvvOaLCg==
X-Received: by 2002:adf:82c6:: with SMTP id 64mr18290820wrc.151.1574441690545;
        Fri, 22 Nov 2019 08:54:50 -0800 (PST)
Received: from dell5510 ([178.21.189.11])
        by smtp.gmail.com with ESMTPSA id t16sm3457448wmt.38.2019.11.22.08.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:54:49 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:54:47 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>
Cc:     Frederik Pasch <fpasch@googlemail.com>,
        Gustavo Zacarias <gustavo@zacarias.com.ar>
Subject: Re: [nfs-utils PATCH 1/1] Switch legacy index() in favour of strchr()
Message-ID: <20191122165447.GA11449@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20191122163155.6971-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122163155.6971-1-petr.vorel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

> From: Frederik Pasch <fpasch@googlemail.com>

NOTE: this fixes build on musl, which has index() only in legacy <strings.h>
(not in <string.h> unlike glibc/uclibc).

Kind regards,
Petr
