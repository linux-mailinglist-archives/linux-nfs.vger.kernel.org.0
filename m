Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDB9693A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 21:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfHTTP3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 15:15:29 -0400
Received: from fieldses.org ([173.255.197.46]:40490 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTTP3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Aug 2019 15:15:29 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 987731E19; Tue, 20 Aug 2019 15:15:28 -0400 (EDT)
Date:   Tue, 20 Aug 2019 15:15:28 -0400
To:     "Goetz, Patrick G" <pgoetz@math.utexas.edu>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Does NFSv4 translate POSIX ACL's?
Message-ID: <20190820191528.GA9039@fieldses.org>
References: <87bee5fc-5461-01b2-ad9d-9c60e86396c1@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bee5fc-5461-01b2-ad9d-9c60e86396c1@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 20, 2019 at 06:35:16PM +0000, Goetz, Patrick G wrote:
> Posting to this list out of desperation, as I've exhausted all the other 
> resources I can get my hands on.

I'm not sure I understand the setup exactly, but it doesn't appear to
have anything to do with ACLs exactly, it's users that are the problem.
You'd have exactly the same problem if you were using only mode bits.

All NFS permissions are evaluated pretty much only on the server side.
When you read a directory, for example, the client doesn't fetch the ACL
and mode bits and check permissions itself.  It just sends the READDIR
(or an ACCESS call) with rpc credentials identifying the user performing
the call, and it's up to the server whether or not to return a
permission error.

Groups are handled differently depending on the security flavor--if
you're using kerberos, it's up to the server to decide which group your
user is a member of.  If you're using auth_sys/auth_unix, then the
client sends a list of groups with each rpc call.  (But the Linux server
has a --manage-gids option that tells the server to ignore that and use
server side group memberships.)

Hope that helps.  This doesn't look like anything to do with ACL
mapping, in any case.

--b.


> The full blown issue has been posted here:
> 
>  
> https://unix.stackexchange.com/questions/536300/why-is-nfsv4-not-translating-posix-acls-in-a-usable-way
> 
> I have an NFSv4 exported folder (base filesystem: XFS) which must afford 
> read access to a program on folders which are otherwise hidden from the 
> public.  On the NFS server:
> 
>    root@kraken:/EM/EMtifs# getfacl pgoetz
>    # file: pgoetz
>    # owner: pgoetz
>    # group: cns-cnsitlabusers
>    user::rwx
>    group::r-x
>    other::---
>    default:user::rwx
>    default:user:cryosparc_user:r-x
>    default:group::r-x
>    default:mask::r-x
>    default:other::---
> 
>    root@kraken:/EM/EMtifs# id cryosparc_user
>    uid=1017(cryosparc_user) gid=1017(cryosparc_user) 
> groups=1017(cryosparc_user)
> 
> 
> The NFS client appears to be translating the POSIX ACL:
> 
>    root@javelina:/EM/EMtifs# nfs4_getfacl pgoetz
>    A::OWNER@:rwaDxtTcCy
>    A::GROUP@:rxtcy
>    A::EVERYONE@:tcy
>    A:fdi:OWNER@:rwaDxtTcCy
>    A:fdi:1017:rxtcy
>    A:fdi:GROUP@:rxtcy
>    A:fdi:EVERYONE@:tcy
> 
>    root@javelina:/EM/EMtifs# id cryosparc_user
>    uid=1017(cryosparc_user) gid=1017(cryosparc_user) 
> groups=1017(cryosparc_user)
> 
> However,
> 
>    cryosparc_user@javelina:/EM/EMtifs$ whoami
>    cryosparc_user
>    cryosparc_user@javelina:/EM/EMtifs$ ls pgoetz
>    ls: cannot open directory 'pgoetz': Permission denied
> 
> Host OS on both machines: Ubuntu 18.04
> NFS version: 1.3.4
> Mount entry in /etc/fstab:
>    kraken.biosci.utexas.edu:/EM  /EM  nfs4  _netdev,auto  0  0
> 
> 
> I found this document that Bruce wrote:
> 
>    https://tools.ietf.org/html/draft-ietf-nfsv4-acl-mapping-02
> 
> but it doesn't appear to have risen to the level of RFC?  RFC 7530 
> doesn't appear to have anything to say on the matter.  Since the 
> processing program primarily runs on the workstations, I need to make 
> this work somehow, and can't add the program user to the user group as 
> explained in the StackExchange post.
> 
> 
