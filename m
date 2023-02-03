Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA95A68A35A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 21:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjBCUCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 15:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjBCUCA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 15:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54795A778F
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675454472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bo39y9URo9GSyCo9yhh1GAf5AInzmPBL23K7jDAaXiA=;
        b=J/vxO9Yn3Xc86cd6bBBww+6LmTyH3GEJIN7Ovtl7PM3KDBl42xGMMTYn5xE6BqIKYvta9G
        u5JpC8YAZhE1iJLIZwxvCryMjwo7XqrYfvEn11M5KD1/M3Pgy02L7gkDONJuUbewmHTcr+
        wbatdAKK1YiytiuQLN1gaiB5DfWOs34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-4zzWHBpyO0iAVmfl6Ds8MA-1; Fri, 03 Feb 2023 15:01:08 -0500
X-MC-Unique: 4zzWHBpyO0iAVmfl6Ds8MA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CCE5885621;
        Fri,  3 Feb 2023 20:01:07 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42049C15BA0;
        Fri,  3 Feb 2023 20:01:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Fri, 03 Feb 2023 15:01:04 -0500
Message-ID: <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
In-Reply-To: <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
 <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
 <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3 Feb 2023, at 13:03, Chuck Lever III wrote:
> Naive suggestion: Would another option be to add server
> support for the directory verifier?

I don't think it would resolve this bug, because what can the client do t=
o
find its place in the directory stream after getting NFS4ERR_NOT_SAME?

Directory verifiers might help another class of bugs, where a linear walk=

through the directory produces duplicate entries.. but I think it only he=
lps
some of those cases.

Knfsd /could/ use the directory verifier to keep a reference to an opened=

directory.  Perhaps knfsd's open file cache can be used.  Then, as long a=
s
we're doing a linear walk through the directory, the local directory's
file->private cursor would continue to be valid to produce consistent lin=
ear
results even if the dentries are removed in between calls to READDIR.

=2E. but that's not how the verifier is supposed to be used - rather it's=

supposed to signal when the client's cookies are invalid, which, for tmpf=
s,
would be anytime any changes are made to the directory.

> Well, let's not argue semantics. The optimization exposes
> this (previously known) bug to a wider set of workloads.

Ok, yes.

> Please, open some bugs that document it. Otherwise this stuff
> will never get addressed. Can't fix what we don't know about.
>
> I'm not claiming tmpfs is perfect. But the optimization seems
> to make things worse for more workloads. That's always been a
> textbook definition of regression, and a non-starter for
> upstream.

I guess I can - my impression has been there's no interest in fixing tmpf=
s
for use over NFS..  after my last round of work on it I resolved to tell =
any
customers that asked for it to do:

[root@fedora ~]# modprobe brd rd_size=3D1048576 rd_nr=3D1
[root@fedora ~]# mkfs.xfs /dev/ram0

=2E. instead.  Though, I think that tmpfs is going to have better perform=
ance.

>> I spent a great deal of time making points about it and arguing that t=
he
>> client should try to work around them, and ultimately was told exactly=
 this:
>> https://lore.kernel.org/linux-nfs/a9411640329ed06dd7306bbdbdf251097c5e=
3411.camel@hammerspace.com/
>
> Ah, well "client should work around them" is going to be a
> losing argument every time.

Yeah, I agree with that, though at the time I naively thought the issues
could be solved by better validation of changing directories.

So.. I guess I lost?  I wasn't aware of the stable cookie issues fully
until Trond pointed them out and I compared tmpfs and xfs.  At that point=
, I
saw there's not really much of a path forward for tmpfs, unless we want t=
o
work pretty hard at it.  But why?  Any production server wanting performa=
nce
and stability on an NFS export isn't going to use tmpfs on knfsd.  There =
are
good memory-speed alternatives.

>> The optimization you'd like to revert fixes a performance regression o=
n
>> workloads across exports of all filesystems.  This is a fix we've had =
many
>> folks asking for repeatedly.
>
> Does the community agree that tmpfs has never been a first-tier
> filesystem for exporting? That's news to me. I don't recall us
> deprecating support for tmpfs.

I'm definitely not telling folks to use it as exported from knfsd.  I'm
instead telling them, "Directory listings are going to be unstable, you'l=
l
see problems." That includes any filesystems with file_operations of
simple_dir_operations.

That said, the whole opendir, getdents, unlink, getdents pattern is maybe=

fine for a test that can assume it has exclusive rights (writes?) to a
directory, but also probably insane for anything else that wants to relia=
bly
remove the thing, and we'll find that's why `rm -rf` still works.  It doe=
s
opendir, getdents, getdents, getdents, unlink, unlink, unlink, .. rmdir.
This more closely corresponds to POSIX stating:

    If a file is removed from or added to the directory after the most re=
cent
    call to opendir() or rewinddir(), whether a subsequent call to readdi=
r()
    returns an entry for that file is unspecified.


> If an optimization broke ext4, xfs, or btrfs, it would be
> reverted until the situation was properly addressed. I don't
> see why the situation is different for tmpfs just because it
> has more bugs.

Maybe it isn't?  We've yet to hear from any authoritative sources on this=
=2E

>> I hope the maintainers decide not to revert
>> it, and that we can also find a way to make readdir work reliably on t=
mpfs.
>
> IMO the guidelines go the other way: readdir on tmpfs needs to
> be addressed first. Reverting is a last resort, but I don't see
> a fix coming before v6.2. Am I wrong?

Is your opinion wrong?  :)  IMO, yes, because this is just another round =
of
"we don't fix the client for broken server behaviors".  If we're going to=

disagree, know that its entirely amicable from my side.  :)

> What I fear will happen is that the optimization will go in, and
> then nobody will address (or even document) the tmpfs problem,
> making it unusable. That would be unfortunate and wrong.
>
> Please look at tmpfs and see how difficult it will be to address
> the cookie problem properly.

I think tmpfs doesn't have any requirement to report consistent offsets i=
n
between calls to close(dir) and open(dir) - so if you re-open the directo=
ry
a second time and seek to some position, you're not going to be able to
connect some earlier part of the stream to what you see now.

So, I don't think its a tmpfs problem - its a bit of a combination of iss=
ues
that contrive to make READDIR results inconsistent on NFS.  The best plac=
e
to improve things might be to have knfsd try to keep the directory open i=
n
between calls to READDIR for filesystems of simple_dir_operations.

Really, the root of the problem is that there's no stateful way to walk a=

directory that's changing, especially if you're expecting things to be th=
e
same in between close() and open().  XFS and ext4 do a pretty good job of=

making that problem disappear by hashing out their dentries across a very=

large range, but without some previous state or versioning, it seems a ha=
rd
problem to solve.

Ben

