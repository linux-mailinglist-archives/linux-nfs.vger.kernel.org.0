Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2EB78D88
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfG2OLs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 10:11:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42090 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfG2OLs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jul 2019 10:11:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id 190so40828120vsf.9
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2019 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1I1WwgDXJhh+Tuva6YPuunwm3cSQkPUBSiNCY6cVLwg=;
        b=raaJR6Val7tr6K4JaeEpHNQ9LVhobYsP6Ush0r+GSJzR0an6uKk1LL5Om4SR7/EpUn
         HR8lzfgWTE8aHvZZr62LSGpoJ/C9TjGfg2/FYrsbrJWEnrTByKeyRm7b+DFWx3EVmFLq
         QdXYJk7AcpFv1dra/dit2h0LwfHpHMM2R+s4lSuk9vp6CUSk1/bhxZ3+dm7wKsFJgpuy
         CoAwwi10IKQXG2kv2lRdNXYxbTkdsyXWRxc5cqVw3355v9YUhOLeIhRmd4LACL4enUu+
         QTjNLiy/NVQfn/C2mSWGRzP9sxMF9TPYf3I7rAZnXjVj+30m2C+CoUF7lTFFFrAZIMRF
         BnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1I1WwgDXJhh+Tuva6YPuunwm3cSQkPUBSiNCY6cVLwg=;
        b=uBgdLyN+Z+Ubkeg3veEFlfjNRY0Hmm5Fqt6yluPvbWJTFkcRSBBkmJ1/VK+9hQz4ur
         6VSuqRq/IqDJQAtQt+H/MT31znFOBNdajt4qpRtj1Zfrbcn2bha0qBWPPm7II/4a7Fbw
         FjNo0gCJ0vEFnqkmeqQ6V04aiSWpiLyIjHbvlOh7Vpl/rXNisAYnJzMg8DzJxzyjCSNh
         X5++Q+QHXx/yYrC3Rti2sBk0p96gDd+DGs6HuCwkTlPui3iXVUhJK6hNI9QiKly+jjH1
         +oiur6v6ienPFuaslphnivm4n40ABWAtr/vByRH5sBPK4DBBzHkRRVGd+sVJvVvXJYPV
         WmMA==
X-Gm-Message-State: APjAAAVDTTKHd5AuhOvb5ulNcISofDDysgeM4DsdTNDk7p/qhz3R3mtz
        evQaw58yILh5TnE7f5RiF57ouUfEj85e5LtCgyE=
X-Google-Smtp-Source: APXvYqxfXLxb4he3ATkWStwY8KydmXriDtZv5pSgEFNrqA3wvqjrm6q3Xx6osKnCzxxvAmYIM5ZgoPWFrsyNVrDCnts=
X-Received: by 2002:a67:dc1:: with SMTP id 184mr8623268vsn.164.1564409507330;
 Mon, 29 Jul 2019 07:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
 <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com> <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
 <016101d5359b$c71f06c0$555d1440$@mindspring.com> <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
 <2d2f5b86-682a-e5d3-b9d9-18573c84073d@cn.fujitsu.com>
In-Reply-To: <2d2f5b86-682a-e5d3-b9d9-18573c84073d@cn.fujitsu.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 29 Jul 2019 10:11:36 -0400
Message-ID: <CAN-5tyHLNDdYBEWcik+EX2X=vRYkt788C=Wif=_tPcQMSuAtjA@mail.gmail.com>
Subject: Re: [PATCH] CACHE: Fix test script as delegation being introduced
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Jorge Mora <Jorge.Mora@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Su,

For nfstest patches, you should cc nfstest maintainer (Jorge Mora
mora@netapp.com).

On Sun, Jul 28, 2019 at 9:56 PM Su Yanjun <suyj.fnst@cn.fujitsu.com> wrote:
>
> Hi bruce.
>
> Sorry for my late reply. Our mail system has some problem that ignores your reply.
>
> I Get the reply by google seach.
>
> We tested the option "clientaddr=0.0.0.0" and the test case also fails.
>
> Thanks
>
> On Mon, Apr 08, 2019 at 10:47:56AM +0800, Su Yanjun<suyj.fnst@cn.fujitsu.com>  wrote:
> > When we run nfstest_cache with nfsversion=4, it fails.
> > As i know nfsv4 introduces delegation, so nfstest_cache runs fail
> > since nfsv4.
> >
> > The test commandline is as below:
> > ./nfstest_cache --nfsversion=4 -e /nfsroot --server 192.168.102.143
> > --client 192.168.102.142 --runtest acregmax_data --verbose all
> >
> > This patch adds compatible code for nfsv3 and nfsv4.
> > When we test nfsv4, just use 'chmod' to recall delegation, then
> > run the test. As 'chmod' will modify atime, so use 'noatime' mount option.
>
> I don't think a chmod is a reliable way to recall delegations.
>
> Maybe mount with "clientaddr=0.0.0.0"?  From the nfs man page:
>
>         Can  specify a value of IPv4_ANY (0.0.0.0) or equivalent IPv6
>         any address  which will  signal to the NFS server that this NFS
>         client does not want delegations.
>
> (I wonder if that documentation's still accurate for versions >= 4.1?)
>
> --b.
> >
> > Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> > ---
> > test/nfstest_cache | 12 +++++++++++-
> > 1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/test/nfstest_cache b/test/nfstest_cache
> > index 0838418..a31d48f 100755
> > --- a/test/nfstest_cache
> > +++ b/test/nfstest_cache
> > @@ -165,8 +165,13 @@ class CacheTest(TestUtil):
> > fd = None
> > attr = 'data' if data_cache else 'attribute'
> > header = "Verify consistency of %s caching with %s on a file" %
> > (attr, self.nfsstr())
> > +
> > # Mount options
> > - mtopts = "hard,intr,rsize=4096,wsize=4096"
> > + if self.nfsversion >= 4:
> > + mtopts = "noatime,hard,intr,rsize=4096,wsize=4096"
> > + else: + mtopts = "hard,intr,rsize=4096,wsize=4096"
> > +
> > if actimeo:
> > header += " actimeo = %d" % actimeo
> > mtopts += ",actimeo=%d" % actimeo
> > @@ -216,6 +221,11 @@ class CacheTest(TestUtil):
> > if fstat.st_size != dlen:
> > raise Exception("Size of newly created file is %d, should have been
> > %d" %(fstat.st_size, dlen))
> > + if self.nfsversion >= 4:
> > + # revoke delegation
> > + self.dprint('DBG3', "revoke delegation")
> > + self.clientobj.run_cmd('chmod +x %s' % self.absfile)
> > +
> > if acregmax:
> > # Stat the unchanging file until acregmax is hit
> > # each stat doubles the valid cache time
> >
> > --
> > 2.7.4
> >
> >
>
>
>
