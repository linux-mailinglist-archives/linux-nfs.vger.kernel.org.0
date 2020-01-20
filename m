Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F256142617
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2020 09:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATIsZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jan 2020 03:48:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33594 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATIsZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jan 2020 03:48:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so28599124wrq.0
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2020 00:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bG7XSdsDdgwbOIQVD92zkZhZY2mXOFcU4dCmCM9SQPk=;
        b=OvTImxenhYwLnE8W1xcFwNUhHkvu8pBw/ExcYW6IAcxHpaa4xfzv4NFu+IxaphK5d8
         DSb9ksvG8m3VdQ7b1dNt+6MMPcHF+Ls4/PfLKIL+pLmzZaE3g9etNDMqEEllX89vh4hr
         /PF34kY5bGBBMeltep7geN7yTuq5PZYqGDKgiXHDeDUNlUGxIygZI77e8w5dSpWyG8hN
         kTz7r4jlLoMFy93Hf6+JbQIWrWPEdln6fRatFLsLgKYJu2+/1UcygStSDBMGeFuDsrJc
         ayDks0xC/sX7Aqb0aEiEjj0ZHYrxBQkCJ+vEEx7KxGCT/YBdWyQvR5ZohY0ZfhMCS0Uh
         YZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bG7XSdsDdgwbOIQVD92zkZhZY2mXOFcU4dCmCM9SQPk=;
        b=SW+njnr8I10Iv6EoBJmeQMBbrPkPKexlVRuHV49igwzCNuENkbZiPdvw6Jqmo4w06p
         wSilJoC1VDF1y0N5SnQ0N/Z0AvnD1bm9KsrWsd1RdQaunlIZJOEBX8VewsSZxveMw5D8
         AYHRrBaps69GhhvPMydgVUiYbrQMhpagexay27xCSFjJSQqWeXopR+Mm0W4sWkyYpgiA
         1Kx/79Suk893IeEAaVGwIZQ+2aKlbwRecKEl7P/k4sBFmszVDEKKhpCQgHowpIWXJ1fF
         9M2peGqylOS72yoSt0Lhdk9wlQ7tynZH89a4xIDlkzKweKpCZtB+VDezvyAuyChZNq1s
         PjwQ==
X-Gm-Message-State: APjAAAULVkJroWvKR/WOrV77lCQ2X1to1JZ8Edi2RTfUzhfxSku/nW2e
        TLbFN95drNiw72mLsjmjAJEC7qE3bBI=
X-Google-Smtp-Source: APXvYqwVK99SbraUwb9YAfBT77mDorz+wrzY96iqdA/AYJpq+WHlmPRwvc9yF4kG7EX6GAluIjMXOA==
X-Received: by 2002:adf:a41c:: with SMTP id d28mr17742440wra.410.1579510103163;
        Mon, 20 Jan 2020 00:48:23 -0800 (PST)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id z4sm21791472wma.2.2020.01.20.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:48:22 -0800 (PST)
Date:   Mon, 20 Jan 2020 09:48:20 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org,
        Mike Frysinger <vapier@gentoo.org>
Subject: Re: [nfs-utils RESENT PATCH 1/1] locktes/rpcgen: tweak how we
 override compiler settings
Message-ID: <20200120084820.GB31890@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200105120502.765426-1-petr.vorel@gmail.com>
 <fb4dd073-856a-7807-eb71-f594e58732cb@RedHat.com>
 <bda9e61c-1a06-5ab3-339f-c38e9a68fb73@RedHat.com>
 <20200114183603.GA24556@dell5510>
 <db2c8006-5520-e34e-b759-42783f965d1c@RedHat.com>
 <5149cf4e-7d78-2cbd-99e4-a4cb66822308@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5149cf4e-7d78-2cbd-99e4-a4cb66822308@benettiengineering.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Giulio, Steve,

> > Note... Giulio's patch is doing something similar
> > https://lore.kernel.org/linux-nfs/20200115160806.99991-1-giulio.benetti@benettiengineering.com/T/#u

> > Does something like that as well as setting the AM_XXX help the your cross-compile?

> IMHO tools/* utility must be built with cross-compiler too, not with
> /usr/bin/gcc. Buildroot provide host-nfs-utils for that, especially for
> rpcgen.

> Please take a look at my WIP patch for bumping nfs-utils to latest in
> Buildroot:
> https://github.com/giuliobenetti/buildroot/commit/12671eb21d62a5474dc476381015069382775668

> and please note this line:
> --with-rpcgen=$(HOST_DIR)/bin/rpcgen

> that means that nfs-utils must use already host-nfs-utils/rpcgen instead of
> internal one to generate rpcs. This is why tools/* is not needed as host to
> build target. Indeed host-nfs-utils is built when nfs-utils is built. At
> least I understand this.

> Can you Petr confirm that?
> Because at this point the patch you're pointing is not needed.

Sorry, I overlooked this mail. Ack, it's correct for buildroot, as I already
wrote yesterday.
But not sure if the patch isn't needed for Gentoo packaging.
I guess if needed, it still can be rebased and applied later.

Kind regards,
Petr
