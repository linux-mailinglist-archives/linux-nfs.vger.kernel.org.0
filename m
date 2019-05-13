Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8CF1C006
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 02:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfENAM1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 20:12:27 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:55760 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfENAM1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 May 2019 20:12:27 -0400
X-Greylist: delayed 35548 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 May 2019 20:12:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1557792747; bh=j8DTOT/0whMaVPMU7SZPkruMGR7/miuaa/5F
        3OmB+MM=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=DCoMbjCDXdS2yzLEtcus2nS0qFAIP7PlL4tIaOBa8AxmKd
        mkve3p3sQE6TlRLH0R844YMC/jfIXWpq2PO7D/YdWVWnbZM18PtNP1eIpAZzLwoDJl+
        5KZKxfCRGz03FEQEUSz1PITXSVXcyBXycV9ew5gF2o4X8yVjJnlrnlYmnwl8k5hmIxf
        7jhFtqpz0XsPUhAZjywLT8LdV9t9LLWXT2rGhBHlIk7P4fcNkGSysQ1g3CeqIJmZOm6
        BuD1ueC1qdIb3d4+/2suqfduTHxBlx8TJ3VpRli6tZax+ESKZwe3peJ8lQcPvBdeKlP
        FlrCSY/B2yV0QK3HBo8AFwFpYfOA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=jBK2a31a7/CwSviJp1xnJxfUWAssnAdKmB9OksACCiQVOscZxL4cYVNXGBWE9Uqr1HMmCoS8gq90dxaHM1p+ceI1iUCLKcyNh+ohp9Jf89DJDMkWj9ZCIOJFyz3x4pQFWWVqw15wxXrAUhOLOr6n5oKxRcFbLp75gMU2eK9ESQgN4xuUHAnkrsx77BiXP1e6Am8SpN0hFmSBbHB+Dqtcr20Z1vzWdEsA0LNFUuHnDO6XZqs98r4ywLHJdHIAJgAUB87tfllyZwmr1yK8NURFpf3rUgr/HzwDDkUmeQRePCFUtG342BzypWJLJ8JCg+WljvcWThPD3Oly8NVW0DQ1VA==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1hQBo4-000DJP-Bg; Mon, 13 May 2019 10:19:56 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Jeff Layton'" <jlayton@kernel.org>
Cc:     <steved@redhat.com>, <linux-nfs@vger.kernel.org>,
        <jfajerski@suse.com>
References: <20190510215445.1823-1-jlayton@kernel.org> <20190511135442.GA15721@fieldses.org> <593884facebf2ebcafcbe577845a961abbaa9928.camel@kernel.org> <20190513134457.GA13359@fieldses.org>
In-Reply-To: <20190513134457.GA13359@fieldses.org>
Subject: RE: [PATCH] manpage: explain why showmount doesn't really work against a v4-only server
Date:   Mon, 13 May 2019 07:19:57 -0700
Message-ID: <08d301d50996$f1cd84e0$d5688ea0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQFQjNPWr+JNRW+mKHkLPq014NiDQgJPLD6bAacjSRIClbrpd6c9szpg
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d68e50a28916d1bbce03f538a8a837459350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Mon, May 13, 2019 at 09:29:42AM -0400, Jeff Layton wrote:
> > Yeah, that certainly wouldn't hurt. I'd suggest we add that in a
> > separate patch though.
> 
> Agreed.
> 
> > We will need to spell this out in the manpage either way. At least
> > with ganesha, you can export some filesystems via v3 and others via v4
> > only, and the MNT service there will only report the v3 ones. In that
> > case, you have a reachable service, but the v4-only filesystems will
> > be missing from showmount's output.
> 
> That doesn't sound like a great idea to me, but maybe you have no choice
if for
> some reason you want to allow simultaneous support for v3-only clients and
for
> filesystems that require long filehandles?  Ugh.
> 
> Anyway, this kind of warning doesn't have to catch every odd case.

Good conversation.

Another thing worth noting in the warning also is that some servers (Ganesha
for sure) will not list exports to showmount that the client issuing the
showmount doesn't have access to (and for NFSv4 they won't show up in the
directory listing).

Obviously the warning can't be perfect, but at least highlighting that the
issue of what exports are visible is complicated.

Frank

