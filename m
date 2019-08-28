Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F862A0937
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfH1SFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 14:05:42 -0400
Received: from fieldses.org ([173.255.197.46]:49372 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1SFm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 14:05:42 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 48F33BD8; Wed, 28 Aug 2019 14:05:41 -0400 (EDT)
Date:   Wed, 28 Aug 2019 14:05:41 -0400
To:     "de Vandiere, Louis" <louis.devandiere@atos.net>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Maximum Number of ACL on NFSv4
Message-ID: <20190828180541.GC29148@fieldses.org>
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
 <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190826164600.GD28580@ndevos-x270>
 <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
 <AM5PR0202MB2564D07CBF6B765EDABAAAB1E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR0202MB2564D07CBF6B765EDABAAAB1E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 26, 2019 at 11:28:21PM +0000, de Vandiere, Louis wrote:
> Thank you Olga! Somehow, I failed to look into this file although I looked in fs/nfs/ without success and I understand why now.
> 
> I'd like to see it increased and be scalable like XFS is, but I understand it might impact multiple libraries. Should I open a bug/feature request somewhere?

I wonder if it'd be OK to remove the limit completely (and then leave
it to the filesystem to reject if if it wants).

It does mean we're passing an arbitrary client-supplied value to
kmalloc.  Is it OK to do that and just leave it to the allocator to
reject excessive requests, or do we risk pushing it into making heroic
efforts to satisfy a possibly malicious or broken client?

I wonder if there's also a risk in passing down posix ACLs larger than
could have been created with the setxattr system call.

Assuming it's still safest to have a limit....

XATTR_LIST_MAX is a global limit on the size of xattrs.  We could try to
estimate how big the converted posix ACL will be and work out a maximum
based on that.

--b.

> 
> Best,
> Louis de Vandière
> 
> -----Original Message-----
> From: Olga Kornievskaia <aglo@umich.edu> 
> Sent: Monday, August 26, 2019 2:31 PM
> To: de Vandiere, Louis <louis.devandiere@atos.net>
> Cc: linux-nfs@vger.kernel.org
> Subject: Re: Maximum Number of ACL on NFSv4
> 
> From fs/nfsd/acl.h
> /*
>  * Maximum ACL we'll accept from a client; chosen (somewhat
>  * arbitrarily) so that kmalloc'ing the ACL shouldn't require a
>  * high-order allocation.  This allows 204 ACEs on x86_64:
>  */
> #define NFS4_ACL_MAX ((PAGE_SIZE - sizeof(struct nfs4_acl)) \
>                         / sizeof(struct nfs4_ace))
> 
> I don't know how Bruce feels about increasing that limit. Perhaps he'd be opened to a patch that increases that.
> 
> On Mon, Aug 26, 2019 at 2:30 PM de Vandiere, Louis <louis.devandiere@atos.net> wrote:
> >
> > Thanks Niels, I tried your suggestion. According to the documentation (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flinux.die.net%2Fman%2F8%2Fmkfs.xfs&amp;data=02%7C01%7Clouis.devandiere%40atos.net%7Ce185f99cb3ad476fd39308d72a5bf6d5%7C33440fc6b7c7412cbb730e70b0198d5a%7C0%7C0%7C637024446785324973&amp;sdata=HZbnVSzTKKCXpEv5JLgZKeEgQx5BPKeEs4SYZqRhhbk%3D&amp;reserved=0), the maximum size for the inode is 2048 byte. So I set it to this value, and faced the exact same limitation. On the other hand, when I used setfacl -m on the XFS mounted disk, I did not face any limitation and I was able to set thousands of ACLs on a single file.
> >
> > When I do a strace, I see two different types of ACL used when the system calls setxattr: system.posix_acl_default and system.nfsv4_acl. I tried to look for hardcoded limits associated with system.nfsv4_acl but I don't have much experience with C and linux kernel.
> >
> > Thank you for your help.
> > Best,
> > Louis de Vandière
> >
> > -----Original Message-----
> > From: Niels de Vos <ndevos@redhat.com>
> > Sent: Monday, August 26, 2019 11:46 AM
> > To: de Vandiere, Louis <louis.devandiere@atos.net>
> > Cc: linux-nfs@vger.kernel.org
> > Subject: Re: Maximum Number of ACL on NFSv4
> >
> > On Mon, Aug 26, 2019 at 02:53:05PM +0000, de Vandiere, Louis wrote:
> > > Yes, I assume it's not very frequent to have hundreds of NFSv4 ACLs. For compliance and organizational issue, we cannot use groups efficiently to manage access to the shares, so it's user-based and case by case.
> > >
> > > My real goal is to be able to replicate some files to a new NFSv4 server while preserving the ACLs. By using "cp -R --preserve=all acl-folder/", I'm able to preserve the ACLs when their number does not exceed 200, above it, I see the "File too large" error while rsync does not work at all (even in version 3.1.3). That's why I'm digging into this and checking what possibly could go wrong.
> >
> > You might be hitting a limit in the filesystem on the NFS server. The 
> > ACLs are stored in extended attributes. Depending on the filesystem, 
> > you may be able to configure larger inode sizes (or other storage for 
> > xattrs). With XFS this can be done with 'mkfs -t xfs -i size=.. ...',
> >
> > HTH,
> > Niels
> >
> >
> > >
> > > Thank you.
> > > Best,
> > > Louis de Vandière
> > >
> > >
> > > -----Original Message-----
> > > From: Goetz, Patrick G <pgoetz@math.utexas.edu>
> > > Sent: Monday, August 26, 2019 8:44 AM
> > > To: de Vandiere, Louis <louis.devandiere@atos.net>; 
> > > linux-nfs@vger.kernel.org
> > > Subject: Re: Maximum Number of ACL on NFSv4
> > >
> > > I'm dying to know what the use case is for this, and why you can't just do this with group permissions (unless you're talking about hundreds of group ACLs).
> > >
> > > On 8/23/19 5:31 PM, de Vandiere, Louis wrote:
> > > > Hi,
> > > >
> > > > I'm currently trying to apply hundreds of ACLs on file hosted on a NFSv4 server (nfs-utils-1.3.0-0.61.el7.x86_64 and nfs4-acl-tools.0.3.3-19.el7.x86_64). It appears that the limit I can apply is 207. After the limit is reached, the command "nfs4_setfacl -a" returned the error "Failed setxattr operation: File too large". The same problem happens if I use an ACL with more than 200 line in it. I did a little debugging session but I was not able to come up with an explanation on why I'm facing such an issue.
> > > >
> > > > On the other hand, I can apply hundreds of ACLs on XFS without issue. Do you know if it could be a bug with the nfs4-acl-tools package?
> > > > Thank you for your support.
> > > > Best,
> > > > Louis de Vandière
> > > >>> This message is from an external sender. Learn more about why this <<
> > > >>> matters at https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flinks.utexas.edu%2Frtyclf&amp;data=02%7C01%7Clouis.devandiere%40atos.net%7Ce185f99cb3ad476fd39308d72a5bf6d5%7C33440fc6b7c7412cbb730e70b0198d5a%7C0%7C0%7C637024446785324973&amp;sdata=r345rqWN4GKT0mBmQmMTnaC%2FFEyUTidjBlGeAMRdEpA%3D&amp;reserved=0.                        <<
> > > >
