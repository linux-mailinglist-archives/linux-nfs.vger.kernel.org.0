Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67792025E9
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgFTSLn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Jun 2020 14:11:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45752 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgFTSLn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Jun 2020 14:11:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id i27so14971493ljb.12
        for <linux-nfs@vger.kernel.org>; Sat, 20 Jun 2020 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YJXnoUA2/iAN+EL5OZk11wBAdHeRZnQaKQlEuEtgT8=;
        b=CF9ffHiovKx04io462jlvPL4EsHlHxVtiyeZzJjQUEmwKYoFAQiecZPuIxgUsKxSbu
         6OClilS0GewKP2T6lzRUfkedW6K/n3cx2qP/5rfaRLw0Slc8QEUAlsPAYTLTocXdxwAW
         xTo3AhkBLYbtjdKyjLGgEXDnPdJTeGNyEcvxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YJXnoUA2/iAN+EL5OZk11wBAdHeRZnQaKQlEuEtgT8=;
        b=r2Z44fo4wcDTBfHW4g252gUQcygEC0TFWBrvmCAlT5iW8fjICdiClKDNhUGF7faJ5W
         RJ1leQ8DvAs0uvw5v1Ew2kw3UVOV4KAfk426QLRMQCtknAm5hI+8aBA/aSCMV0lQUoW2
         BjLUWL+3uBc6xJRep9hcqkXB4FHK4DbGKNwx9euyV9vIs25QFAfHMO99zIyWq7bWlB4W
         db+qiNy1t42DBtNedmJHTuzz8mbmsqIJnafjo4RW/N9oiQfFAhwzPLG2rmcLe8zOIWz6
         /+wuc1lWRHJg+CO4WnuEnTW92YY893cnDiRa/qHMt9qwcmUTjtnxFCZUVk/h6pzAkfTa
         8X/g==
X-Gm-Message-State: AOAM531KIHNjjSJwXeHcm/+GykLqtTcJsGq2UwISJPifsosRsINNzsIB
        x7eOCr0Wt14wCC+A28Wldzf5GGKvzAg=
X-Google-Smtp-Source: ABdhPJys+auUO5ZRMEyUqVPlBc7D7y33vn1A7CViyJ54vSzFAJ4D7UVF9ddykh27E5pQ1zHTKGHwNQ==
X-Received: by 2002:a2e:b8d5:: with SMTP id s21mr4476180ljp.34.1592676640483;
        Sat, 20 Jun 2020 11:10:40 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id u8sm2206433lff.38.2020.06.20.11.10.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 11:10:39 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id n23so14994701ljh.7
        for <linux-nfs@vger.kernel.org>; Sat, 20 Jun 2020 11:10:39 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr4372477ljn.70.1592676639017;
 Sat, 20 Jun 2020 11:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200611155743.GC16376@fieldses.org> <CAADWXX9tV_khCjrO5eUJQry+QV4VLatt21KEkJ8irEcuqTbBsQ@mail.gmail.com>
 <20200611181141.GD16376@fieldses.org> <20200620165504.GG1514@fieldses.org>
In-Reply-To: <20200620165504.GG1514@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 11:10:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6KKyy-d0foGXguj1p1RtLg8mNNdeTHgs053rfAaAYPw@mail.gmail.com>
Message-ID: <CAHk-=wg6KKyy-d0foGXguj1p1RtLg8mNNdeTHgs053rfAaAYPw@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for 5.8
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 20, 2020 at 9:55 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Anyway, hopefully things are better now.

This email certainly looked fine. You had

    DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; ...

with the proper headers ("From" shows up twice in your DKIM signature
list, and maybe you could add the message-id to the DKIM-protected
headers, but whatever), and google clearly liked the end result too:

       dkim=pass header.i=@fieldses.org header.s=default header.b=z+wyI4pO;

(and you already had the SPF records previously, and that continues to
pass too).

So from what I can tell, you're now doing everything you can to look
like a good modern non-spam email sender, and hopefully together with
having the Linode addresses cleared from Spamhaus there would be no
reason for gmail to ever hate you again.

In fact, you look better than most people. DKIM still isn't as common
as it perhaps should be.

Knock wood.

            Linus
