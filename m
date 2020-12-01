Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348BF2CACF3
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 21:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgLAUC7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 15:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbgLAUC4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 15:02:56 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069BC0613CF
        for <linux-nfs@vger.kernel.org>; Tue,  1 Dec 2020 12:02:10 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id y22so5253978edv.1
        for <linux-nfs@vger.kernel.org>; Tue, 01 Dec 2020 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yAi9JJd878fV2T2paWqW4KNzktFAL978RZFzWp0Kjuo=;
        b=IUxuBQrsTotc0dzZSAx2k2muX5ywcKYzatiz9ynyJM5/A32uHvJC2JuWjQEsA1gAYE
         xZ3GgC6OdT4Zh9mQsS+HHDV8hikUXC0r021IAnyUJbTh/bvPAbzY84pV7FmlR/N8koDX
         Qbaq5RlqZsiWN6pz+aNC+CtVpapHYVRXBZY5emHY8xRPSjOvBn4JBo7fF4P5ahKOImeL
         r24jO88zJmS+M6FqR7uBbiSOiyosi4pGTd4MbrrfceAxs//MR1/NvI94KNmKVrrL82ze
         xCpnszShH8yBG7ShywYxY1f48A1CmtXjwAEx8YVHapA5uJNv1cuKad+/YGySlJ3Vghx6
         1gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yAi9JJd878fV2T2paWqW4KNzktFAL978RZFzWp0Kjuo=;
        b=g3SqU+fAVZb7qdzoHrHnPiRmNglgNLRvBiq1EboTuCM/8jU/i7K/IlLf48mHkWDDLi
         MpcT543nCvQU+DrEGrjbW5U18sP8mZQF151iNAOKbAjanH1WbTXEVrmvyFze+qQpSBxy
         TnxXmh0ekCr7hHShbiUtkxWimq3R/BdPTF136Jh97YnXA7NUu/BNznPSYu0BLiJxeHm3
         MO3XIfbV3bpOoecLG6QZ/g7y/R3aWPTOLdsMGdXfGKQnAh6hS4iBDcZxAdCHoTZKIzYd
         eJXxxju4oSoVjHc32aPRYeNX0Mnf05Cu+Alq5HlBvyyxPygoGf/Ag+vNyGB9XRL72iTU
         QEaw==
X-Gm-Message-State: AOAM532TnOAGXOBtMzyWNtfVr/he3+URXtw3fPS/5zsSQgYV16nP1RvG
        kKmYeMVVkrsW1Wj4c4U1QiOFtmdA49JQKu9P3XU=
X-Google-Smtp-Source: ABdhPJxq7plGzF1wV3UiwYYInX1nqdUiydFYRIfVs4u10DF2LxWwA8zmhwIB+vHSEwJBmz7OvqIkAfKpg7XsZflxjas=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr4755840edm.28.1606852929171;
 Tue, 01 Dec 2020 12:02:09 -0800 (PST)
MIME-Version: 1.0
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B1CF6271-B168-4571-B8E4-0CAB0A0B40FB@netapp.com> <20201124211926.GB14140@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <5571DE63-1276-4AF6-BB8F-EE36878B06E5@netapp.com> <20201126002149.GA2339@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B791B088-49C4-42F3-8721-A022027625D3@oracle.com> <20201126193248.GA6578@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20201126193248.GA6578@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 1 Dec 2020 15:01:57 -0500
Message-ID: <CAN-5tyFbC4dmRg4sXCPirp64qnYwN1Ykw4oRA+4sBsD+NG6Fiw@mail.gmail.com>
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new
 LISTXATTRS operation
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 27, 2020 at 3:40 AM Frank van der Linden
<fllinden@amazon.com> wrote:
>
> On Thu, Nov 26, 2020 at 12:10:21PM -0500, Chuck Lever wrote:
> >
> >
> > > On Nov 25, 2020, at 7:21 PM, Frank van der Linden <fllinden@amazon.co=
m> wrote:
> > >
> > > On Tue, Nov 24, 2020 at 10:40:25PM +0000, Kornievskaia, Olga wrote:
> > >>
> > >>
> > >> =EF=BB=BFOn 11/24/20, 4:20 PM, "Frank van der Linden" <fllinden@amaz=
on.com> wrote:
> > >>
> > >>    On Tue, Nov 24, 2020 at 08:50:36PM +0000, Kornievskaia, Olga wrot=
e:
> > >>>
> > >>>
> > >>> On 11/24/20, 3:06 PM, "Frank van der Linden" <fllinden@amazon.com> =
wrote:
> > >>>
> > >>>    On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> By switching to an XFS-backed export, I am able to reproduce the
> > >>>> ibcomp worker crash on my client with xfstests generic/013.
> > >>>>
> > >>>> For the failing LISTXATTRS operation, xdr_inline_pages() is called
> > >>>> with page_len=3D12 and buflen=3D128. Then:
> > >>>>
> > >>>> - Because buflen is small, rpcrdma_marshal_req will not set up a
> > >>>>  Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
> > >>>>  get invoked at all.
> > >>>>
> > >>>> - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
> > >>>>  copy received data into rq_rcv_buf->pages, but they're missing.
> > >>>>
> > >>>> The result is that the ibcomp worker faults and dies. Sometimes th=
at
> > >>>> causes a visible crash, and sometimes it results in a transport
> > >>>> hang without other symptoms.
> > >>>>
> > >>>> RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, an=
d
> > >>>> should eventually be fixed or replaced. However, my preference is
> > >>>> that upper-layer operations should explicitly allocate their recei=
ve
> > >>>> buffers (using GFP_KERNEL) when possible, rather than relying on
> > >>>> XDRBUF_SPARSE_PAGES.
> > >>>>
> > >>>> Reported-by: Olga kornievskaia <kolga@netapp.com>
> > >>>> Suggested-by: Olga kornievskaia <kolga@netapp.com>
> > >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > >>>> ---
> > >>>> fs/nfs/nfs42proc.c |   17 ++++++++++-------
> > >>>> fs/nfs/nfs42xdr.c  |    1 -
> > >>>> 2 files changed, 10 insertions(+), 8 deletions(-)
> > >>>>
> > >>>> Hi-
> > >>>>
> > >>>> I like Olga's proposed approach. What do you think of this patch?
> > >>>>
> > >>>>
> > >>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > >>>> index 2b2211d1234e..24810305ec1c 100644
> > >>>> --- a/fs/nfs/nfs42proc.c
> > >>>> +++ b/fs/nfs/nfs42proc.c
> > >>>> @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct=
 inode *inode, void *buf,
> > >>>>                .rpc_resp       =3D &res,
> > >>>>        };
> > >>>>        u32 xdrlen;
> > >>>> -       int ret, np;
> > >>>> +       int ret, np, i;
> > >>>>
> > >>>>
> > >>>>        res.scratch =3D alloc_page(GFP_KERNEL);
> > >>>> @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(stru=
ct inode *inode, void *buf,
> > >>>>                xdrlen =3D server->lxasize;
> > >>>>        np =3D xdrlen / PAGE_SIZE + 1;
> > >>>>
> > >>>> +       ret =3D -ENOMEM;
> > >>>>        pages =3D kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> > >>>> -       if (pages =3D=3D NULL) {
> > >>>> -               __free_page(res.scratch);
> > >>>> -               return -ENOMEM;
> > >>>> +       if (pages =3D=3D NULL)
> > >>>> +               goto out_free;
> > >>>> +       for (i =3D 0; i < np; i++) {
> > >>>> +               pages[i] =3D alloc_page(GFP_KERNEL);
> > >>>> +               if (!pages[i])
> > >>>> +                       goto out_free;
> > >>>>        }
> > >>>>
> > >>>>        arg.xattr_pages =3D pages;
> > >>>> @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(stru=
ct inode *inode, void *buf,
> > >>>>                *eofp =3D res.eof;
> > >>>>        }
> > >>>>
> > >>>> +out_free:
> > >>>>        while (--np >=3D 0) {
> > >>>>                if (pages[np])
> > >>>>                        __free_page(pages[np]);
> > >>>>        }
> > >>>> -
> > >>>> -       __free_page(res.scratch);
> > >>>>        kfree(pages);
> > >>>> -
> > >>>> +       __free_page(res.scratch);
> > >>>>        return ret;
> > >>>>
> > >>>> }
> > >>>> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > >>>> index 6e060a88f98c..8432bd6b95f0 100644
> > >>>> --- a/fs/nfs/nfs42xdr.c
> > >>>> +++ b/fs/nfs/nfs42xdr.c
> > >>>> @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct r=
pc_rqst *req,
> > >>>>
> > >>>>        rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->co=
unt,
> > >>>>            hdr.replen);
> > >>>> -       req->rq_rcv_buf.flags |=3D XDRBUF_SPARSE_PAGES;
> > >>>>
> > >>>>        encode_nops(&hdr);
> > >>>> }
> > >>>>
> > >>>>
> > >>>
> > >>>    I can see why this is the simplest and most pragmatic solution, =
so it's
> > >>>    fine with me.
> > >>>
> > >>>    Why doesn't this happen with getxattr? Do we need to convert tha=
t too?
> > >>>
> > >>> [olga] I don't know if GETXATTR/SETXATTR works. I'm not sure what t=
ests exercise those operations. I just ran into the fact that generic/013 w=
asn't passing. And I don't see that it's an xattr specific tests. I'm not s=
ure how it ends up triggering is usage of xattr.
> > >>
> > >>    I'm attaching the test program I used, it should give things a be=
tter workout.
> > >>
> > >> [olga] I'm not sure if I'm doing something wrong but there are only =
2 GETXATTR call on the network trace from running this application and both=
 calls are returning an error (ERR_NOXATTR). Which btw might explain why no=
 problems are seen since no decoding of data is happening. There are lots o=
f SETXATTRs and REMOVEXATTR and there is a LISTXATTR (which btw network tra=
ce is marking as malformed so there might something bad there). Anyway...
> > >>
> > >> This is my initial report: no real exercise of the GETXATTR code as =
far as I can tell.
> > >
> > > True, the test is heavier on the setxattr / listxattr side. And with =
caching,
> > > you're not going to see a lot of GETXATTR calls. I used the same test=
 program
> > > with caching off, and it works fine, though.
> >
> > I unintentionally broke GETXATTR while developing the LISTXATTRS fix,
> > and generic/013 rather aggressively informed me that GETXATTR was no
> > longer working. There is some test coverage there, fwiw.
>
> Oh, the coverage was good - in my testing I also used a collection of
> small unit test programs, and I was the one who made the xattr tests
> in xfstests work on NFS.

I have just oops-ed the kernel trying to send a getxattr when
userspace provided a small buffer.

File with extended attributes was created using your application but
modified to leave the file behind. Then I coded up this to get the
extended attirbutes. Test coverage doesn't test for this.

int main(int argc, char *argv[]) {

int fd, len =3D 8;
char buf[8];

fd =3D open("/mnt/test_xattr_probeJxfiVU", O_RDWR | O_CREAT, S_IRWXU);
if (fd < 0) exit(0);

if (getxattr("/mnt/test_xattr_probeJxfiVU", "user.test_xattr_probe",
buf, len) < 0) exit(0);

return 0;
}

Which again produces the KASAN's
[ 5915.393103] BUG: KASAN: wild-memory-access in
rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]


This is my proposed fix. Will send a proper patch if agreed:

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 4fc61e3d098d..720fbaddcb90 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1189,12 +1189,17 @@ static ssize_t _nfs42_proc_getxattr(struct
inode *inode, const char *name,
  .rpc_argp =3D &arg,
  .rpc_resp =3D &res,
  };
- int ret, np;
+ int ret =3D -ENOMEM, np =3D NFS4XATTR_MAXPAGES, i;

+ for (i =3D 0; i < NFS4XATTR_MAXPAGES; i++) {
+ pages[i] =3D alloc_page(GFP_KERNEL);
+ if (!pages[i])
+ goto out_free_pages;
+ }
  ret =3D nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
     &res.seq_res, 0);
  if (ret < 0)
- return ret;
+ goto out_free_pages;

  /*
  * Normally, the caching is done one layer up, but for successful
@@ -1209,16 +1214,19 @@ static ssize_t _nfs42_proc_getxattr(struct
inode *inode, const char *name,
  nfs4_xattr_cache_add(inode, name, NULL, pages, res.xattr_len);

  if (buflen) {
- if (res.xattr_len > buflen)
- return -ERANGE;
+ if (res.xattr_len > buflen) {
+ ret =3D -ERANGE;
+ goto out_free_pages;
+ }
  _copy_from_pages(buf, pages, 0, res.xattr_len);
  }

- np =3D DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
+ ret =3D res.xattr_len;
+out_free_pages:
  while (--np >=3D 0)
  __free_page(pages[np]);

- return res.xattr_len;
+ return ret;
 }

 static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,

>
> >
> >
> > > In any case, after converting GETXATTR to pre-allocate pages, I notic=
ed that,
> > > when I disabled caching, I was getting EIO instead of ERANGE back fro=
m
> > > calls that test the case of calling getxattr() with a buffer length t=
hat
> > > is insufficient.
> >
> > Was TCP the underlying RPC transport?
>
> Yes, this was TCP. I have set up rdma over rxe, which I'll test too if I
> can get this figured out. It might be a long standing bug in xdr_inline_p=
ages,
> as listxattr / getxattr seem to be simply the first ones to pass in a
> length that is not page aligned.
>
> It does make some sense to round the length up to PAGE_SIZE, and just che=
ck if
> the received data fits when decoding, like other calls do. It improves yo=
ur
> chances of getting a result that you can still cache, even if it's too bi=
g for
> the length that was asked for. E.g. if the result is > requested_length, =
but
> < ROUND_UP(requested_length, PAGE_SIZE), you can cache it, even though yo=
u
> have to return -ERANGE to the caller.
>
> - Frank
