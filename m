Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4364A2C44FA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgKYQZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 11:25:23 -0500
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:56020 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730946AbgKYQZX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 11:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1606321522; bh=apQZXDuS9ET/pVKp02ey5l08vxqX2QdLw+Lu
        iTXjhSY=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=cm9tPgUaaeJPbND7yuggtnjhp28/u0viIwK1PH9I/xkT2/
        bJOi0+ei6wfxz/nT9t8/R9PNXGFZju2euzGTVpF3319EcioQwXborH4g+keGMQ6S6+C
        9AIdRq5wMFKBOZjsAxKTnCfDUVdxctPTmzbxMUjMTQzttdw/vkF+1bi27M+zFGizpgD
        IjVnT228CI0jywvCkHsOVU/dOaGZTDVoeLiU1WwgiAyZkfy/AvKcs8OR2UPyj8HUlzl
        QERjwpLMSQCDR97UglGyAPFbzhYTsjHztA47lgzZ7Kzm9Tt1BxmaHxcn7oxDs1K11JY
        i3Xn8Pw5RT/3bAR0lxAMuzO1ZHbg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=FKVa5HHAFdGr42qI9P8GJ3YGIWEh3YOzaXOX2pJxHaw4jVKiYXHvewCJi/RvKD03Y7ZOqZD7UN+SXjCNExxDNW8gR3CvvwKVaPWk2acOLMhf16h5LuxWr/Aq138Orc8LvJxhixgDtxCjwpi3L9gYWApNF0YHtxIZ5w+E13MWHAK7UfCddNhYqHUvtS+aFcAV69ZXJICmV+E0KqpA0xXAFqdFgxm3wj+ID/DtOVloeu3brn6985NNLYXER/UtQumd3DWGAgmJnM0MDX/mKqqwqdYxEkjU1h9b/4ycRcnLCvRsOArjfE0sUdAU7ZQAz2XnK2RN2kPsWsA7DqcWKomi4g==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1khxbb-000DVh-Dm; Wed, 25 Nov 2020 11:25:19 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'bfields'" <bfields@fieldses.org>
Cc:     "'Daire Byrne'" <daire@dneg.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-cachefs'" <linux-cachefs@redhat.com>,
        "'linux-nfs'" <linux-nfs@vger.kernel.org>
References: <20200915172140.GA32632@fieldses.org> <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com> <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com> <20201124211522.GC7173@fieldses.org> <0fc201d6c2af$62b039f0$2810add0$@mindspring.com> <20201125144753.GC2811@fieldses.org>
In-Reply-To: <20201125144753.GC2811@fieldses.org>
Subject: RE: Adventures in NFS re-exporting
Date:   Wed, 25 Nov 2020 08:25:19 -0800
Message-ID: <100101d6c347$917ed0f0$b47c72d0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIMJHTNaUfUC7mKmsL3ACLiQeb3JQI9CmfpAttHNL0B+hIAfgE5qoLXAZr58eYBXdorRQGLCl71AmNKoMYCnwzJbwKcKMdYqMrOhjA=
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4dce8fa129a7039943542fba0e7dc78578350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Tue, Nov 24, 2020 at 02:15:57PM -0800, Frank Filz wrote:
> > How much conversation about re-export has been had at the wider NFS
> > community level? I have an interest because Ganesha  supports
> > re-export via the PROXY_V3 and PROXY_V4 FSALs. We currently don't have
> > a data cache though there has been discussion of such, we do have
attribute
> and dirent caches.
> >
> > Looking over the wiki page, I have considered being able to specify a
> > re-export of a Ganesha export without encapsulating handles. Ganesha
> > encapsulates the export_fs handle in a way that could be coordinated
> > between the original server and the re-export so they would both
> > effectively have the same encapsulation layer.
> 
> In the case the re-export server only servers a single export, I guess you
could do
> away with the encapsulation.  (The only risk I see is that a client of the
re-export
> server could also access any export of the original server if it could
guess
> filehandles, which might surprise
> admins.)  Maybe that'd be useful.

Ganesha handles have a minor downside that is a help here if Ganesha was
re-exporting another Ganesha server. There is a 16 bit export_id that comes
from the export configuration and is part of the handle. We could easily set
it up so that if the sysadmin configured it as such, each re-exported
Ganesha export would have the same export_id, and then a client handle for
export_id 1 would be mirrored to the original server as export_id 1 and the
two servers can have the same export permissions and everything.

There is some additional stuff we could easily implement in Ganesha to
restrict handle manipulation to sneak around export permissions.

> Another advantage of not encapsulating filehandles is that clients could
more
> easily migrate between servers.

Yea, with the idea I've been mulling for Ganesha, migration between original
server and re-export server would be simple with the same handles. Of course
state migration is a whole different ball of wax, but a clustered setup
could work just as well as Ganesha's clustered filesystems. On the other
hand, re-export with state has a pitfall. If the re-export server crashes,
the state is lost on the original server unless we make a protocol change to
allow state re-export such that a re-export server crashing doesn't cause
state loss. For this reason, I haven't rushed to implement lock state
re-export in Ganesha, rather allowing the re-export server to just manage
lock state locally.

> Cooperating servers could have an agreement on filehandles.  And I guess
we
> could standardize that somehow.  Are we ready for that?  I'm not sure what
> other re-exporting problems there are that I haven't thought of.

I'm not sure how far we want to go there, but potentially specific server
implementations could choose to be interoperable in a way that allows the
handle encapsulation to either be smaller or no extra overhead. For example,
if we implemented what I've thought about for Ganesha-Ganesha re-export,
Ganesha COULD also be "taught" which portion of the knfsd handle is the
filesystem/export identifier, and maintain a database of Ganesha
export/filesystem <-> knfsd export/filesystem and have Ganesha
re-encapsulate the exportfs/name_to_handle_at portion of the handle. Of
course in this case, trivial migration isn't possible since Ganesha will
have a different encapsulation than knfsd.

Incidentally, I also purposefully made Ganesha's encapsulation different so
it never collides with either version of knfsd handles (now if over the
course of the past 10 years another handle version has come along...).

Frank

> --b.
> 
> > I'd love to see some re-export best practices shared among server
> > implementations, and also what we can do to improve things when two
> > server implementations are interoperating via re-export.

