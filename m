Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB46500C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 03:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfGKB71 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jul 2019 21:59:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33878 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfGKB71 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jul 2019 21:59:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so4076635ljg.1
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2019 18:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=MQOzZI79mvoiVs1sgBWHfqE+YJM9b7M05jQpHMpAAyRFe0Cs7GZ1SKjYmbrPj6ztHM
         B7Jmo2E1tOKxmtYLHAeJfiv0Yw5iWNpJ6su3Aywbxq++FWe46hRTt1FaTYFdrs51gDai
         Fc+1NUhQh/izklmNT0WE5mkHqoWlVg+hybjs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=M86bxgxXBQaDUUrxWlUcVhjTl5ecHkBydbuavq7j5y0ORreW6coV+6/0KysgPncQ50
         WiI7RgjT0iyN9hrUFlvFtSDeO4TEx9YG3+LKti65tZ6CpNfV1EKntBq2ytQTopFOoAHB
         U1XMKZrgVuMGhZiJSroLq6ilM+RBzjeycWJx2gf6NlGgg1xuF6Up1OtpjARcBovbdsO9
         36aUZZtsqiR/aRAvqVCXH+LZ3xPJwMtrdAWMCoG1/aLhrbY9GqgNu2icBhEUivQ0MYje
         9MLIG9M9naqpO/tFsgi+coS+Mlosir10z5BjX27pUSkg1cRC7NEjLnsJkztgtkY5jYQc
         TGOA==
X-Gm-Message-State: APjAAAWJC7WNFG9H4w5AktKIefLvYSxTVJuOzWodvZQvLpJ7RTdZdniT
        cFEZwwUMywQY8frx4cwIbsdQVwAKuyo=
X-Google-Smtp-Source: APXvYqwT9PFZPQK/xCFn0ugjbxc6Vt2V/v7kNTKEt5r+48lMOjeIAJIAvGsT8Sx3pZsDfr9+4rPKrA==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr748075ljj.60.1562810363673;
        Wed, 10 Jul 2019 18:59:23 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id s1sm722234ljd.83.2019.07.10.18.59.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 18:59:22 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 62so2908798lfa.8
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr355474lft.79.1562810361547;
 Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <28477.1562362239@warthog.procyon.org.uk> <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
 <20190710194620.GA83443@gmail.com> <20190710201552.GB83443@gmail.com>
In-Reply-To: <20190710201552.GB83443@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 18:59:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 10, 2019 at 1:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Also worth noting that the key ACL patches were only in linux-next for 9 days
> before the pull request was sent.

Yes. I was not entirely happy with the whole key subsystem situation.
See my concerns in

  https://lore.kernel.org/lkml/CAHk-=wjEowdfG7v_4ttu3xhf9gqopj1+q1nGG86+mGfGDTEBBg@mail.gmail.com/

for more. That was before I realized it was buggy.

So it really would be good to have more people involved, and more
structure to the keys development (and, I suspect, much else under
security/)

Anyway, since it does seem like David is offline, I've just reverted
this from my tree, and will be continuing my normal merge window pull
requests (the other issues I have seen have fixes in their respective
trees).

                 Linus
