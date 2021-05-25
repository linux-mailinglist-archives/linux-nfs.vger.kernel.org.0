Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4363903F4
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhEYOde (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 10:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233813AbhEYOde (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 May 2021 10:33:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621953123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hA+hv9ZCo6bQ/6WJreGYm7InmnZZu080JpABje2zNg0=;
        b=drTLrEkJJsnlFeeYEUdaSU0GWxrkC9yLtnphPFtngOnOr6Rw7VVPvdYSjaLYC7fMJoHZIP
        3zoLIY+18c7Z5A+zXXvEmKE3pZowYYPVjJMs/WHLxlkCN5XPs3bUijEv2hvBJtXl6eerRM
        SqwWrAMqPaA8QmFKUezzdyvfJLmOxns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621953123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hA+hv9ZCo6bQ/6WJreGYm7InmnZZu080JpABje2zNg0=;
        b=lw5ieP7KUBMMc/bF0MFgse+kj4r6MQCuw+/NOvb+42/6bTBRHU8ay5oizM8w+LYMntZ8OI
        zm8f0oEnhRejsjDQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81A18AB71;
        Tue, 25 May 2021 14:32:03 +0000 (UTC)
Date:   Tue, 25 May 2021 16:32:01 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, "Yong Sun (Sero)" <yosun@suse.com>
Subject: Re: [PATCH pynfs 2/3] server: Allow to print JSON format
Message-ID: <YK0KYU4iOZypr3Td@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210524144251.30196-1-pvorel@suse.cz>
 <20210524144251.30196-2-pvorel@suse.cz>
 <YK0FV/mvmbIzSpKJ@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK0FV/mvmbIzSpKJ@pick.fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

> I've got nothing against this, but I'm curious why you need it.
Well, I can integrate it via XML, but JSON is just a bit more readable.
So it's up to you.
Having code in XML (and JSON if accepted) would be nice.

I prefer to have well defined format instead of parsing showresults.py output
(originally I though I'd add JSON to showresults.py, but then I noticed
--xml in testserver.py).

Kind regards,
Petr

> --b.
