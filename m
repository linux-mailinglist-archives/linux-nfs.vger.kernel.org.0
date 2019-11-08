Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB44F50B1
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKHQJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 11:09:25 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:46021 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKHQJY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Nov 2019 11:09:24 -0500
Received: by mail-vs1-f47.google.com with SMTP id l5so4111021vsh.12
        for <linux-nfs@vger.kernel.org>; Fri, 08 Nov 2019 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgR8SbJM/LwWNsFT9KWb1wzEtiup6uUwZwyMnR0ES20=;
        b=A6HKo7SEd/6iRY8fMOWCgHk2G+aH0sCZWuEDpPBzIdu9IY1MzhDq/9LMPpmAMFbFUq
         0xVr/8aZo3f4e5NuhVpyE1Ohoq5WVYXReeE7gR4n1T28cZdEhOgSu/+uniaGRXkeIrK5
         k7Q+Pbb+/f9EApA2uIbxIYrgXA/sHsZbyObJ/EL0avAtU2DsHimvBRSc3ZEWwk7AnCWg
         zKiRp8mfD9PdZuj7gkrM8XV4yyA0Z97jE1RqOk7xWxu152sgdiMixyJvyGt4vfPa0Vqb
         7a6Is/7ZG7ducw6qIbzpCAgFdIY+Un4f88A6ll3qsadjI9qAx5/Z4rbpIlxeH1dWg9PM
         4wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgR8SbJM/LwWNsFT9KWb1wzEtiup6uUwZwyMnR0ES20=;
        b=Gd9KSHpo5zTR8WVvC/QCwb1ygxpXVwq8MBkAbVnMLDMkO8q+IuN0/zMsNyE21WAbch
         QI/OU2TAO9X1KOTN86HRcd9W63Zemfrir0ZmRj5OINNF6BRNrQ5vyOFu3swMksyYU2lu
         J6ZIswLzU0qXQbqThZpkR2daEzQEG1GUvNHvHW50so+sJ6tGU4hxtVkfub9pFwdbwAdm
         RCigVnlB5M1V/QAJQevxdYi7pL2YFy7Hzd2sc9uVBNLpe5Fe1nYFJmPtFd4Q3Akp5nAZ
         RdFZ1wT68sDwkY7ygAvwpktcIjpDTHLG48rck7QMnl3Tdso2u354fD4bLNwggSUsLLJi
         0pXQ==
X-Gm-Message-State: APjAAAUvUECSdZRmuRcl4hluJ2yMYrg3lzpLmtzyDFOrx5mE2C97s2fo
        7HObzWJ16q9r9hlnguPrwiBePrVgF618lvSc6B5kxA==
X-Google-Smtp-Source: APXvYqyA0OAYCSxC7OFm4jGux5/J3qikyMOIVaK3MUAqt8h3TiWMRuBCMdYzq3Ju2Cn9PF6g/AV0VXDb92E1eZmlr4Y=
X-Received: by 2002:a05:6102:21b4:: with SMTP id i20mr8731659vsb.164.1573229361668;
 Fri, 08 Nov 2019 08:09:21 -0800 (PST)
MIME-Version: 1.0
References: <5DBD272A-0D55-4D74-B201-431D04878B43@ascha.org>
In-Reply-To: <5DBD272A-0D55-4D74-B201-431D04878B43@ascha.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 8 Nov 2019 11:09:10 -0500
Message-ID: <CAN-5tyF7F4Mc8Z-bwg+Rq-ok50mchyF+X24oE8_MZzVy8LRCmw@mail.gmail.com>
Subject: Re: Specific IP per mounted share from same server
To:     Samy Ascha <samy@ascha.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Samy,

Are you going against a linux server? I don't think linux server has
the functionality you are looking for. What you are really looking for
I believe is session trunking and neither the linux client nor server
fully support that (though we plan to add that functionality in the
near future).

Bruce, correct me if I'm wrong but linux server doesn't support
multi-home (multi-node?) therefore, it has no ability to distinguish
requests coming from different network interfaces and then present
different server major/minor/scope values and also return different
clientids in that case as well. So what happens now even though the
client is establishing a new TCP connection via the 2nd network, the
server returns back to the client same clientid and server identity as
the 1st mount thus client will use an existing connection it already
has.

On Fri, Nov 8, 2019 at 3:48 AM Samy Ascha <samy@ascha.org> wrote:
>
> Hi!
>
> I have an NFS server with 2 NICs, configured on different subnets. These subnets are on different network segments (2 dedicated switches).
>
> I have clients that mount 2 distinct shares from this server. Expecting to spread the network load, I specified the mounts like so, in fstab:
>
> 10.110.1.235:/srv/nfs/www    /var/www    nfs defaults,rw,intr,nosuid,noatime,vers=4.1 0 0
> 10.110.0.235:/srv/nfs/backup    /backup   nfs defaults,rw,intr,nosuid,noatime,vers=4.1 0 0
>
> However, as you may find totally expected, I see both mounts connected to the same IP on the server. Specificly, the one specified for the first mount:
>
> 10.110.1.235:/srv/nfs/www on /var/www type nfs4 (rw,...)
> 10.110.1.235:/srv/nfs/backup on /backup type nfs4 (rw,...)
>
> Is this expected? Am I wrong to assume that this is a possible setup? If possible/forcible, what am I missing / doing wrong? :)
>
> Thanks much,
> Samy
