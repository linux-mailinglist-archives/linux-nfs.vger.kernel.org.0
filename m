Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D260CA0A2F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfH1TJP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 15:09:15 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41241 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfH1TJP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 15:09:15 -0400
Received: by mail-ua1-f67.google.com with SMTP id x2so348410uar.8
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kckuasxQLwdnRjNlo9EYU+uicXD7SthFsysleRXyNuo=;
        b=U/QtVsLmjqkBwiK9j0gXOPmctPa0w4vG/s6soufETJ/0G4gt03+i8oLjVbzhvyHlZJ
         vCQWQVw1rBQJI1TVu5VAkSzOyy0GjpJNe6JNiucqlmflpbXrrnIrSSTWWsPYGPVEUuWL
         NEH7BR9xsM0WTsj6rPLbBtrs6y8e+/yH/9jhJ/jeibmu9PGxbqrTPNEJt6mi0Ape2+PT
         4gWmuUhF816qSh3lnJzSBTKxnFkZeNKtOMjdPE+4MubBpuDQ/nuntawRfDeOJw8z536Q
         CQtr0XHL5M/W7ylwkit67Gn6GtVdgDYbTT1cBqnF9fkeuBz4ABxjtd3ySn4gawyJa8fe
         WP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kckuasxQLwdnRjNlo9EYU+uicXD7SthFsysleRXyNuo=;
        b=OPcWHq7P/r0JzRQjALAJ8Tao+mwhdjil5HLnWNfnLAPW72ttLQYif1+fBgunTyKU82
         QfZFA12OROFjcL2UvM0zQtKNFpSB7vN+SDNYZzW8J1j7IA8JJeEsDqguKD7BZvPezcgU
         z8f0IUF/GWHKclskW5YbSSIfrMUCZUajPBS/Z17vdnpg4zl5TBsFWxfW22qV54meNtmV
         6izfZ+g0qQ9wF+iqaM1VSyCWf9kIX5ksbTH0dK0nlPZC84LhJ3FymNHvdZrvM6F++Bct
         lUDX4Ryiv2oRlwXSM1f0RlwGh62zZ5TnhwFpi+dwlOgQMWhux+PPyJBWsnjGXJHpyO4n
         WsoA==
X-Gm-Message-State: APjAAAWb87hllvXos5govKpLE+e1AC1q56hN1XJixCnXLxS/uabqAE27
        cGM0omSLCNtapMvAxC+Gkg++nHkmHXZfIC5W9t4ZpzmU
X-Google-Smtp-Source: APXvYqxfDNvvLuagKj4vlYzhq2NVVbgqvRI5xfpV6VKO1CU9wEcoblzZD9ebuZJoWYnftE2RT/C8Ook+TnEpVZ7iRvw=
X-Received: by 2002:ab0:810:: with SMTP id a16mr2720283uaf.93.1567019354057;
 Wed, 28 Aug 2019 12:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu> <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190826164600.GD28580@ndevos-x270> <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
 <AM5PR0202MB2564D07CBF6B765EDABAAAB1E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190828180541.GC29148@fieldses.org>
In-Reply-To: <20190828180541.GC29148@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 28 Aug 2019 15:09:03 -0400
Message-ID: <CAN-5tyEth0YYiuS0oe8Q_LN-7Z8NXiF3hJPj1sL5MYCXjF-jnQ@mail.gmail.com>
Subject: Re: Maximum Number of ACL on NFSv4
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "de Vandiere, Louis" <louis.devandiere@atos.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 2:06 PM J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>
> On Mon, Aug 26, 2019 at 11:28:21PM +0000, de Vandiere, Louis wrote:
> > Thank you Olga! Somehow, I failed to look into this file although I loo=
ked in fs/nfs/ without success and I understand why now.
> >
> > I'd like to see it increased and be scalable like XFS is, but I underst=
and it might impact multiple libraries. Should I open a bug/feature request=
 somewhere?
>
> I wonder if it'd be OK to remove the limit completely (and then leave
> it to the filesystem to reject if if it wants).
>
> It does mean we're passing an arbitrary client-supplied value to
> kmalloc.  Is it OK to do that and just leave it to the allocator to
> reject excessive requests, or do we risk pushing it into making heroic
> efforts to satisfy a possibly malicious or broken client?
>
> I wonder if there's also a risk in passing down posix ACLs larger than
> could have been created with the setxattr system call.
>
> Assuming it's still safest to have a limit....
>
> XATTR_LIST_MAX is a global limit on the size of xattrs.  We could try to
> estimate how big the converted posix ACL will be and work out a maximum
> based on that.

I agree there should be a limit and using XATTR_LIST_MAX sounds
reasonable to me.

>
> --b.
>
> >
> > Best,
> > Louis de Vandi=C3=A8re
> >
> > -----Original Message-----
> > From: Olga Kornievskaia <aglo@umich.edu>
> > Sent: Monday, August 26, 2019 2:31 PM
> > To: de Vandiere, Louis <louis.devandiere@atos.net>
> > Cc: linux-nfs@vger.kernel.org
> > Subject: Re: Maximum Number of ACL on NFSv4
> >
> > From fs/nfsd/acl.h
> > /*
> >  * Maximum ACL we'll accept from a client; chosen (somewhat
> >  * arbitrarily) so that kmalloc'ing the ACL shouldn't require a
> >  * high-order allocation.  This allows 204 ACEs on x86_64:
> >  */
> > #define NFS4_ACL_MAX ((PAGE_SIZE - sizeof(struct nfs4_acl)) \
> >                         / sizeof(struct nfs4_ace))
> >
> > I don't know how Bruce feels about increasing that limit. Perhaps he'd =
be opened to a patch that increases that.
> >
> > On Mon, Aug 26, 2019 at 2:30 PM de Vandiere, Louis <louis.devandiere@at=
os.net> wrote:
> > >
> > > Thanks Niels, I tried your suggestion. According to the documentation=
 (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flinux=
.die.net%2Fman%2F8%2Fmkfs.xfs&amp;data=3D02%7C01%7Clouis.devandiere%40atos.=
net%7Ce185f99cb3ad476fd39308d72a5bf6d5%7C33440fc6b7c7412cbb730e70b0198d5a%7=
C0%7C0%7C637024446785324973&amp;sdata=3DHZbnVSzTKKCXpEv5JLgZKeEgQx5BPKeEs4S=
YZqRhhbk%3D&amp;reserved=3D0), the maximum size for the inode is 2048 byte.=
 So I set it to this value, and faced the exact same limitation. On the oth=
er hand, when I used setfacl -m on the XFS mounted disk, I did not face any=
 limitation and I was able to set thousands of ACLs on a single file.
> > >
> > > When I do a strace, I see two different types of ACL used when the sy=
stem calls setxattr: system.posix_acl_default and system.nfsv4_acl. I tried=
 to look for hardcoded limits associated with system.nfsv4_acl but I don't =
have much experience with C and linux kernel.
> > >
> > > Thank you for your help.
> > > Best,
> > > Louis de Vandi=C3=A8re
> > >
> > > -----Original Message-----
> > > From: Niels de Vos <ndevos@redhat.com>
> > > Sent: Monday, August 26, 2019 11:46 AM
> > > To: de Vandiere, Louis <louis.devandiere@atos.net>
> > > Cc: linux-nfs@vger.kernel.org
> > > Subject: Re: Maximum Number of ACL on NFSv4
> > >
> > > On Mon, Aug 26, 2019 at 02:53:05PM +0000, de Vandiere, Louis wrote:
> > > > Yes, I assume it's not very frequent to have hundreds of NFSv4 ACLs=
. For compliance and organizational issue, we cannot use groups efficiently=
 to manage access to the shares, so it's user-based and case by case.
> > > >
> > > > My real goal is to be able to replicate some files to a new NFSv4 s=
erver while preserving the ACLs. By using "cp -R --preserve=3Dall acl-folde=
r/", I'm able to preserve the ACLs when their number does not exceed 200, a=
bove it, I see the "File too large" error while rsync does not work at all =
(even in version 3.1.3). That's why I'm digging into this and checking what=
 possibly could go wrong.
> > >
> > > You might be hitting a limit in the filesystem on the NFS server. The
> > > ACLs are stored in extended attributes. Depending on the filesystem,
> > > you may be able to configure larger inode sizes (or other storage for
> > > xattrs). With XFS this can be done with 'mkfs -t xfs -i size=3D.. ...=
',
> > >
> > > HTH,
> > > Niels
> > >
> > >
> > > >
> > > > Thank you.
> > > > Best,
> > > > Louis de Vandi=C3=A8re
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Goetz, Patrick G <pgoetz@math.utexas.edu>
> > > > Sent: Monday, August 26, 2019 8:44 AM
> > > > To: de Vandiere, Louis <louis.devandiere@atos.net>;
> > > > linux-nfs@vger.kernel.org
> > > > Subject: Re: Maximum Number of ACL on NFSv4
> > > >
> > > > I'm dying to know what the use case is for this, and why you can't =
just do this with group permissions (unless you're talking about hundreds o=
f group ACLs).
> > > >
> > > > On 8/23/19 5:31 PM, de Vandiere, Louis wrote:
> > > > > Hi,
> > > > >
> > > > > I'm currently trying to apply hundreds of ACLs on file hosted on =
a NFSv4 server (nfs-utils-1.3.0-0.61.el7.x86_64 and nfs4-acl-tools.0.3.3-19=
.el7.x86_64). It appears that the limit I can apply is 207. After the limit=
 is reached, the command "nfs4_setfacl -a" returned the error "Failed setxa=
ttr operation: File too large". The same problem happens if I use an ACL wi=
th more than 200 line in it. I did a little debugging session but I was not=
 able to come up with an explanation on why I'm facing such an issue.
> > > > >
> > > > > On the other hand, I can apply hundreds of ACLs on XFS without is=
sue. Do you know if it could be a bug with the nfs4-acl-tools package?
> > > > > Thank you for your support.
> > > > > Best,
> > > > > Louis de Vandi=C3=A8re
> > > > >>> This message is from an external sender. Learn more about why t=
his <<
> > > > >>> matters at https://eur01.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flinks.utexas.edu%2Frtyclf&amp;data=3D02%7C01%7Clouis.devan=
diere%40atos.net%7Ce185f99cb3ad476fd39308d72a5bf6d5%7C33440fc6b7c7412cbb730=
e70b0198d5a%7C0%7C0%7C637024446785324973&amp;sdata=3Dr345rqWN4GKT0mBmQmMTna=
C%2FFEyUTidjBlGeAMRdEpA%3D&amp;reserved=3D0.                        <<
> > > > >
