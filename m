Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B212FAEE7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 03:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbhASCtG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jan 2021 21:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbhASCtE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jan 2021 21:49:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65398C061573
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jan 2021 18:48:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x20so26924636lfe.12
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jan 2021 18:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VP90uzRWG8ET0bUgTwgbH4HHBonlJmpV2GM64GHQE9o=;
        b=EQs2Fb7yUeTlCeeR25s70PeRgIqP99wHBPKsQbxZLsoyHRJ4JTH1kLydP1E05pJM+c
         K7S1VybMcPTnqqeNZBR7JGNPaNoPASNLmkvWd6XARLizWT/jLYKjYiZcsfI5UzfCe7im
         JKzYx7qPbfeqR5iRwqMUXc2ZyvYfk5yLafUHQoy5hcvv/dOdf3zF6Rrt9myz2l0983A1
         P+fJe4fVlTr6w66HMAKJONKu5vuxyN34Qv5cg43c/UVdbdmhngkzKTVLyHyZ5neYi2XH
         XpWaC0l0KE0QQr1T7ABY/0fk/5L/lNKDSpNIoGl9Vdg78y2N9+DvVsDlAAI5mJyr9Xjp
         V1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VP90uzRWG8ET0bUgTwgbH4HHBonlJmpV2GM64GHQE9o=;
        b=ATJNJmB0/ZwelFm3Q5w/yKT4+D0BaH46f7lnyY2BgcEh9LDU0sXYWXbQDGZcy87yYq
         lgvGL7/PZ+rebrKKSUIA2gTpmcwYE0XkmN81VrWcMxGlmfem9LgrF/i6QIkVGoq1fgCp
         acb5+95CiEgdg+XtC2jCVqr9pksGnlbjEnPcLef/xUtRQOjHgA70FCQMqnrFpzmn3K6d
         MCpIJZG+ncKDNATJ83laM6DUTM8KqwM4FewuW4q7fnjUxDCM/lRb2aZKSGEHRhcLOMyy
         aPktN/AeKDXnkexC5OjUM1r4kseJxf8AgIuM9nBGHVfD8LqBEIjrznoUJH1PXvka9jbz
         uABw==
X-Gm-Message-State: AOAM530iQ2VSwzmQxiOP0exFpYal3t9y9nWflDYwM9cDfUrWJr/7aptP
        Rr/sJAOe6Lxmavg+PWBOQ4Zj2s5hBzG83SdXQQIOz1V5XXORWQ==
X-Google-Smtp-Source: ABdhPJyXnbx9/hAxdvIrS8GQCMNTKcslGvUAwnnTLAD0TenTsqkmJhdxThTE10DiSV8d2g9kHNn+JPx6oT0bsA/HWWQ=
X-Received: by 2002:ac2:46ca:: with SMTP id p10mr876519lfo.53.1611024502934;
 Mon, 18 Jan 2021 18:48:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9a:1198:0:b029:ae:7594:3151 with HTTP; Mon, 18 Jan 2021
 18:48:22 -0800 (PST)
In-Reply-To: <20210118225557.GB23934@fieldses.org>
References: <20210108152017.GA4183@fieldses.org> <20210108152607.GA950@1wt.eu>
 <20210108153237.GB4183@fieldses.org> <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org> <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org> <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <CAHxDmpQVxOPmA6o535yEC34fNrA2Of=_W-f49L6gDvxVC3FH6w@mail.gmail.com> <20210118225557.GB23934@fieldses.org>
From:   =?UTF-8?B?5ZC05byC?= <wangzhibei1999@gmail.com>
Date:   Tue, 19 Jan 2021 10:48:22 +0800
Message-ID: <CAHxDmpQdYHrL8_voEMRJ6kNUuWApz3a_KxD_88LTrJviivTkpQ@mail.gmail.com>
Subject: Re: nfsd vurlerability submit
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

My patch is below:
/fs/nfsd/nfsfh.c

nfsd_acceptable(void expv,struct dentry *dentry)
{
-     if(exp->ex_flags & NFSEXP_NOSUBTREEXHECK)
-     return 1;

+     if(is_root_export(exp))
+       return 1;

+    /* If not subdirectory export, accept anything*/

}




=E5=9C=A8 2021=E5=B9=B41=E6=9C=8819=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C=EF=
=BC=8Cbfields@fieldses.org <bfields@fieldses.org> =E5=86=99=E9=81=93=EF=BC=
=9A
> On Tue, Jan 19, 2021 at 12:29:28AM +0800, =E5=90=B4=E5=BC=82 wrote:
>> I want to consult you on what is the original intention of designing
>> subtree_check and whether it is to solve the  'I want to export a
>> subtree of a filesystem' problem.
>>
>> As far as I know, when opening subtree_check, the folder's  file
>> handle does not contain the inode information of its parent directory
>> and
>> 'while (tdentry !=3D exp->ex_path.dentry && !IS_ROOT(tdentry))' in
>> nfsd_acceptable can work well to Intercept handles beyond the export
>> point.
>>
>> This seems to delete code as follows in nfsfh.c could solve the  'I
>> want to export a subtree of a filesystem' problem and ensure safety:
>> if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)
>> return 1;
>>
>> Or replace by follow:
>> if (exp->ex_path.dentry =3D=3D exp->vfs_mount->mnt_root)
>> return 1;
>>
>> When I was reading the nfsd code, I was confused about whether the
>> designer used the file system as a security boundary or an export
>> point.Since exporting a complete file system is the safest, why not
>> directly prohibit unsafe practices, but add code like subtree_check to
>> try to verify the file handle.
>
> Sorry, I honestly don't understand the question.
>
> If you have a specific proposal, perhaps you could send a patch.
>
> --b.
>
>>
>> I may not understand your design ideas.
>>
>> Yours sincerely,
>>
>> Trond Myklebust <trondmy@hammerspace.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=
=8813=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:53=E5=86=99=E9=81=93=
=EF=BC=9A
>> >
>> > On Tue, 2021-01-12 at 10:32 -0500, J. Bruce Fields wrote:
>> > > On Tue, Jan 12, 2021 at 10:48:00PM +0800, =E5=90=B4=E5=BC=82 wrote:
>> > > > Telling users how to configure the exported file system in the mos=
t
>> > > > secure
>> > > > way does
>> > > > mitigate the problem to some extent, but this does not seem to
>> > > > address the
>> > > > security risks posed by no_ subtree_ check in the code. In my
>> > > > opinion,when
>> > > > the generated filehandle does not contain the inode information of
>> > > > the
>> > > > parent directory,the nfsd_acceptable function can also recursively
>> > > > determine whether the request file exceeds the export path
>> > > > dentry.Enabling
>> > > > subtree_check to add parent directory information only brings some
>> > > > troubles.
>> > >
>> > > Filesystems don't necessarily provide us with an efficient way to
>> > > find
>> > > parent directories from any given file.  (And note a single file may
>> > > have multiple parent directories.)
>> > >
>> > > (I do wonder if we could do better in the directory case, though.  W=
e
>> > > already reconnect directories all the way back up to the root.)
>> > >
>> > > > I have a bold idea, why not directly remove the file handle
>> > > > modification in
>> > > > subtree_check, and then normalize the judgment of whether dentry
>> > > > exceeds
>> > > > the export point directory in nfsd_acceptable (line 38 to 54 in
>> > > > /fs/nfsd/nfsfh.c) .
>> > > >
>> > > > As far as I understand it, the reason why subtree_check is not
>> > > > turned on by
>> > > > default is that it will cause problems when reading and writing
>> > > > files,
>> > > > rather than it wastes more time when nfsd_acceptable.
>> > > >
>> > > > In short,I think it's open to question whether the security of the
>> > > > system
>> > > > depends on the user's complete correct configuration(the system
>> > > > does not
>> > > > prohibit the export of a subdirectory).
>> > >
>> > > > Enabling subtree_check to add parent directoryinformation only
>> > > > brings
>> > > > some troubles.
>> > > >
>> > > > In short,I think it's open to question whether the security of the
>> > > > system depends on the user's complete correct configuration(the
>> > > > system
>> > > > does not prohibit the export of a subdirectory).
>> > >
>> > > I'd love to replace the export interface by one that prohibited
>> > > subdirectory exports (or at least made it more obvious where they're
>> > > being used.)
>> > >
>> > > But given the interface we already have, that would be a disruptive
>> > > and
>> > > time-consuming change.
>> > >
>> > > Another approach is to add more entropy to filehandles so they're
>> > > harder
>> > > to guess; see e.g.:
>> > >
>> > >         https://www.fsl.cs.stonybrook.edu/docs/nfscrack-tr/index.htm=
l
>> > >
>> > > In the end none of these change the fact that a filehandle has an
>> > > infinite lifetime, so once it's leaked, there's nothing you can do.
>> > > The
>> > > authors suggest NFSv4 volatile filehandles as a solution to that
>> > > problem, but I don't think they've thought through the obstacles to
>> > > making volatile filehandles work.
>> > >
>> > > --b.
>> >
>> > The point is that there is no good solution to the 'I want to export a
>> > subtree of a filesystem' problem, and so it is plainly wrong to try to
>> > make a default of those solutions, which break the one sane case of
>> > exporting the whole filesystem.
>> >
>> > Just a reminder that we kicked out subtree_check not only because a
>> > trivial rename of a file breaks the client's ability to perform I/O by
>> > invalidating the filehandle. In addition, that option causes filehandl=
e
>> > aliasing (i.e. multiple filehandles pointing to the same file) which i=
s
>> > a major PITA for clients to try to manage for more or less the same
>> > reason that it is a major PITA to try to manage these files using
>> > paths.
>> >
>> > The discussion on volatile filehandles in RFC5661 does try to address
>> > some of the above issues, but ends up concluding that you need to
>> > introduce POSIX-incompatible restrictions, such as trying to ban
>> > renames and deletions of open files in order to make it work.
>> >
>> > None of these compromises are necessary if you export a whole
>> > filesystem (or a hierarchy of whole filesystems). That's the sane case=
.
>> > That's the one that people should default to using.
>> >
>> > --
>> > Trond Myklebust
>> > Linux NFS client maintainer, Hammerspace
>> > trond.myklebust@hammerspace.com
>> >
>> >
>
