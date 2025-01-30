Return-Path: <linux-nfs+bounces-9804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FACA2354F
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 21:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058B518880B5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F171EE7CB;
	Thu, 30 Jan 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="NzZCblch"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9D196DB1
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269808; cv=none; b=IrGNDd942x1HysHK5az2BB88YVNiLt5ABKSaHI5JiE6HTLcG6+rLl8MUIvKlT/RzNe9YWGRShC7ZImb8CGlKqLUNdwKDH7ATxykvTk64wYPvzDWFpmLSJzct1KRexA4TkEO2he9iGnx6dS1BErrUr8cewAi/DkidCtBX8KaPR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269808; c=relaxed/simple;
	bh=Kl8oDTI/MwHB1o6aa+7MvgVaXyNIQttMJsOdtimFRRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXm4qQW80bcxKhdvZBtL2Uim1c0ddRAXSqOeVCLGDi9jAFSVL4d+5Y0sRttQxTxzg/SWmzoWhNH2Qbn96qOsXEgnL2QfgjocD2PYUmndSU+TMLhCPb8ihTNpPMKlhoxRGXBoGkh72y+cyI9DcDBLjKQtF5WEHQweAHS8bLJ7eKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=NzZCblch; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3043e84c687so10604841fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1738269804; x=1738874604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1wCHZLWJ9MkwMWR7UmMG83ks4FtSFFKM7CudHta88Y=;
        b=NzZCblchRgNFajAAXqIdv2P1/Yrgjbz/zNdjyZBLYo+w4Whx9mSTvS/hcUYJRJFPGO
         60cQrl0j8RGFj0z0gpA4UgpfTrA3J5Co805HXtz1rZrvgAAOOHCfjCMxIXAJYHSGOZcS
         pE1b8DcaUZMcf5P/jS27VR/pE2VZexI6nfEYzMQOFmXkacSnT3LG9DyL9KgH8rv+7Dy/
         uM3aqPt2p1j+mjHK7ZPCgmTpfUboCxN11oF332pxV2mPbFP00qfRN/uqFpgH8LtGgOyY
         7ptLY4zaVQ6WZSx1vY3J/mIPv7CUlU8ye5qU/D5xi1DqK4sgyjfDFwrfyl3bZdfExIMr
         lORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738269804; x=1738874604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1wCHZLWJ9MkwMWR7UmMG83ks4FtSFFKM7CudHta88Y=;
        b=TtGZaCy1Ab67tDTDx3Nfuy2NEA/v7MO7Bfw4i4FeCi6/o0ASQl2oMzuorOiyjZ6V0+
         Xn6+FJRAOioCrhqf9NVKmGu0iL3cGrsiAgoQA2g21EwqOU0XV4NLLcLs4tK/zDCD5PDR
         z3foeP6PL4a0PEN5BOIvpo67oIdtaqYx9m0ne00JkttmiyoOfI9JEtrgNImH1wWCIOAc
         LIBv5GdnjUfd9BWoHxy03fPoq8GRU4NNsmKnf8m0vPkWhogDNAB/c8vqiBf1X2PeFszh
         nL2SoEHzlnFbsC5sBXMfOnR0CmE3ttxPVklvIUAzfAAO+kDV4kraHEJE00WmsBnFAlAn
         KKgg==
X-Forwarded-Encrypted: i=1; AJvYcCWs4hF/Qxqb1E91y/wxom1PwOiRPG7il6FF5isLOrkjTgGC+d5p7HPjWPpYTyArQRD3053DYJrVBzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznRwf+VGM9BXGo4FdqFk+iES0b4CBegMGZy+XUYb+H315Ou8FG
	TWzXb4zbbCsO8MPhbAaE++hV7FU9MlRrbfif1sfbVY3VfOAcU23lDpkRU4ps5KedKcY8BjmYFr+
	wylYUUDcrktcKuP98quxiDtE8mQ8=
X-Gm-Gg: ASbGncvCQYRiUrSg0KJSEzm/0gFgJBUKfm7AYgxGK+dOuJDxH4rvu/mJXx2I5oWAMqd
	xpCjEA635gLuhbKxflaebfKrmQW2FdO4DW7PZH/OJG07pvo28ccpBpO8mNuVAFnYGiEVsW4lkPC
	iVZkWvGsh/xoPFHs1eINUjtfAHcovdm/Y=
X-Google-Smtp-Source: AGHT+IHdw4dhJv1r8/kZ2tdyM7VtecL5rhI6e1H5CveAvIFgOd8uJPFbPE3nbA5LAW7eB9V5t9eWnt0fZ8YFqN3v2Io=
X-Received: by 2002:a2e:9fc2:0:b0:301:12:1ef3 with SMTP id 38308e7fff4ca-3079680c6b0mr40596001fa.4.1738269803686;
 Thu, 30 Jan 2025 12:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
 <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com> <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
 <a2ffc62e7698aa4b40712e11cf766d964a7cc646.camel@hammerspace.com>
 <24c6c65e-4e6e-423e-afea-b9f3407be4d5@oracle.com> <afb9f3f0-0fd5-4b8c-b407-7676a9267e8b@oracle.com>
 <b6e28487-ac25-4835-a052-c084db309648@oracle.com>
In-Reply-To: <b6e28487-ac25-4835-a052-c084db309648@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 30 Jan 2025 15:43:12 -0500
X-Gm-Features: AWEUYZkN8V3qPB7ovpDWFOhV3qVBoXoGoa-yRScY3BRmBI4Nu2tU0F-FtYR_HV4
Message-ID: <CAN-5tyGEHkdmXnepzfx7cxmjRcM6b7zou7ooyo=i0VfOPmZNFA@mail.gmail.com>
Subject: Re: fstests failures with NFSD attribute delegation support
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Thomas Haynes <loghyr@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:50=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/4/25 5:00 PM, Chuck Lever wrote:
> > On 12/30/24 10:33 AM, Chuck Lever wrote:
> >> On 12/29/24 8:52 PM, Trond Myklebust wrote:
> >>> On Sun, 2024-12-29 at 17:37 -0500, Chuck Lever wrote:
> >>>> On 12/19/24 3:15 PM, Chuck Lever wrote:
> >>>>> On 12/18/24 4:02 PM, Chuck Lever wrote:
> >>>>>> Hi -
> >>>>>>
> >>>>>> I'm testing the NFSD support for attribute delegation, and seeing
> >>>>>> these
> >>>>>> two new fstests failures: generic/647 and generic/729. Both tests
> >>>>>> emit
> >>>>>> this error message:
> >>>>>>
> >>>>>>     mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT):
> >>>>>> 0 !=3D
> >>>>>> 4096: Bad address
> >>>>>>
> >>>>>> This is 100% reproducible with the new patches applied to the
> >>>>>> server,
> >>>>>> and 100% not reproducible when they are not applied on the
> >>>>>> server.
> >>>>>>
> >>>>>> The failure is due to pread64() (on the client) returning EFAULT.
> >>>>>> On
> >>>>>> the wire, the passing test does:
> >>>>>>
> >>>>>> SETATTR (size =3D 0)
> >>>>>> WRITE (offset =3D 4096, len =3D 4096)
> >>>>>> READ (offset =3D 0, len =3D 8192)
> >>>>>> READ (offset =3D 4096, len =3D 4096)
> >>>>>> SETATTR (size =3D 0)
> >>>>>>    [ continues until test passes ]
> >>>>>>
> >>>>>> The failing test does:
> >>>>>>
> >>>>>> SETATTR (size =3D 0)
> >>>>>> WRITE (offset =3D 4096, len =3D 4096)
> >>>>>>    [ the failed pread64 seems to occur here ]
> >>>>>> CLOSE
> >>>>>>
> >>>>>> In other words, in the failing case, the client does not emit
> >>>>>> READs
> >>>>>> to pull in the changed file content.
> >>>>>>
> >>>>>> The test is using O_DIRECT so I function-traced
> >>>>>> nfs_direct_read_schedule_iovec(). In the passing case, this
> >>>>>> function
> >>>>>> generates the usual set of NFS READs on the wire and returns
> >>>>>> successfully.
> >>>>>>
> >>>>>> In the failing case, iov_iter_get_pages_alloc2() invokes
> >>>>>> get_user_pages_fast(), and that appears to fail immediately:
> >>>>>>
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310394:
> >>>>>> funcgraph_entry:
> >>>>>>>         get_user_pages_fast() {
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310395:
> >>>>>> funcgraph_entry:
> >>>>>>>           gup_fast_fallback() {
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
> >>>>>> 0.262
> >>>>>> us   |          __pte_offset_map();
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
> >>>>>> 0.142
> >>>>>> us   |          __rcu_read_unlock();
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry:
> >>>>>> 7.824
> >>>>>> us   |          __gup_longterm_locked();
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
> >>>>>> 8.967 us
> >>>>>>>          }
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
> >>>>>> 9.224 us
> >>>>>>>        }
> >>>>>>      mmap-rw-fault-623256 [016] 175303.310404:
> >>>>>> funcgraph_entry:
> >>>>>>>         kvfree() {
> >>>>>>
> >>>>>> My guess is the cached inode file size is still zero.
> >>>>>
> >>>>> Confirmed: in the failing case, the read fails because the cached
> >>>>> file size is still zero. In the passing case, the cached file size
> >>>>> is
> >>>>> 8192 before the read.
> >>>>>
> >>>>> During the test, the client truncates the file, then performs an
> >>>>> NFS
> >>>>> WRITE to the server, extending the size of the file. When an
> >>>>> attribute
> >>>>> delegation is in effect, that size extension isn't reflected in the
> >>>>> cached value of i_size -- the client ensures that INVALID_SIZE is
> >>>>> always clear.
> >>>>>
> >>>>> But perhaps the NFS client is relying on the client's VFS to
> >>>>> maintain
> >>>>> i_size...? The NFS client has its own direct I/O implementation, so
> >>>>> perhaps an i_size update is missing there.
> >>>>
> >>>> Because the client never retrieves the file's size from the server
> >>>> during either the passing or failing cases, this appears to be a
> >>>> client
> >>>> bug.
> >>>>
> >>>> The bug is in nfs_writeback_update_inode() -- if mtime is delegated,
> >>>> it
> >>>> skips the file extension check, and the file size cached on the
> >>>> client
> >>>> remains zero after the WRITE completes.
> >>>>
> >>>> The culprit is commit e12912d94137 ("NFSv4: Add support for delegate=
d
> >>>> atime and mtime attributes"). If I remove the hunk that this commit
> >>>> adds to nfs_writeback_update_inode(), both generic/647 and
> >>>> generic/729
> >>>> pass.
> >>>>
> >>>>
> >>>
> >>> I'm confused... If O_DIRECT is set on open(), then the NFSv4.x (x>0)
> >>> client will set NFS4_SHARE_WANT_NO_DELEG. Furthermore, it should not
> >>> set either NFS4_SHARE_WANT_DELEG_TIMESTAMPS or
> >>> NFS4_SHARE_WANT_OPEN_XOR_DELEGATION.
> >>
> >> Examining wire captures...
> >>
> >>
> >> In the passing test (done with NFSv4.1 to the same server), there is
> >> indeed an OPEN with OPEN4_SHARE_ACCESS_WANT_NO_DELEG followed by the
> >> WRITE to offset 4096 for 4096 bytes. The client returns this OPEN stat=
e
> >> ID immediately (via CLOSE).
> >>
> >> Then an OPEN that returns both an OPEN state ID and a WRITE delegation=
.
> >> The client uses the delegation state ID for reading, enabling the test
> >> to pass.
> >
> > The above is not correct. Upon closer examination, the delegation state
> > ID is used for the direct WRITE in this case, even though an OPEN state
> > ID is available.
> >
> > But since nfs_have_delegated_mtime() returns false,
> > nfs_writeback_update_inode() proceeds to update the cached file size.
> >
> >
> >> There are three OPENs on the wire during the failing test.
> >>
> >> The first two set OPEN4_SHARE_ACCESS_WANT_NO_DELEG. For those, the
> >> server returns an OPEN stateid, delegation type OPEN_DELEGATE_NONE_EXT=
,
> >> and WND4_NOT_WANTED is set.
> >>
> >> The third OPEN appears to request any kind of open. The share_access
> >> field contains the raw value 00300003. The rightmost "3" is SHARE_BOTH=
.
> >> I assume the leftmost "3" means WANT_DELEG_TIMESTAMPS and OPEN_XOR;
> >> wireshark doesn't currently recognize those bits.
> >>
> >> NFSD returns an OPEN_DELEGATE_WRITE_ATTRS_DELEG in response to this
> >> request, with a delegation state ID and no OPEN state ID.
> >>
> >> The client uses this delegation state ID for subsequent write
> >> operations. The write completions fail to extend the cached file
> >> size due to the presence of the delegation.
> >
> > Here again the client presents the delegation state ID during the WRITE=
.
> > But since the write delegation also permits delegated time stamps,
> > nfs_writeback_update_inode() skips the file size update.
> >
> > In both cases, nfs4_select_rw_stateid() is choosing a delegation
> > state ID for a direct WRITE. In the this case, it's choosing the
> > delegation state ID because it has no OPEN state ID (due to
> > OPEN_XOR_DELEG being set).
> >
> > nfs4_map_atomic_open_share() seems to be selecting the wrong
> > bits to enable for this test... ?
> >
>
> The test application opens the target file without O_DIRECT, performs
> one or two chores, then closes the file. It then opens the same file
> with O_DIRECT.
>
> The problem arises because, on close(2), the client caches the open
> state acquired by the first (non-O_DIRECT) open(2). It emits neither a
> CLOSE nor a DELEGRETURN.
>
> For the subsequent O_DIRECT open(2), a fresh OPEN is not emitted. The
> client uses the cached open state for direct WRITEs -- in fact, it uses
> the delegation state ID from that cached open state.

The use of a delegation stateid doesn't seem to be a problem for when
this test is run on 4.1.

I think you had to correct before when the problem was with how the
client deals with updating the attributes (now that it got a delegated
attribute ability).

The problematic chunk in the mentioned patch is the following:

@@ -1514,6 +1516,13 @@ void nfs_writeback_update_inode(struct
nfs_pgio_header *hdr)
        struct nfs_fattr *fattr =3D &hdr->fattr;
        struct inode *inode =3D hdr->inode;

+       if (nfs_have_delegated_mtime(inode)) {
+               spin_lock(&inode->i_lock);
+               nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
+               spin_unlock(&inode->i_lock);
+               return;
+       }
+
        spin_lock(&inode->i_lock);
        nfs_writeback_check_extend(hdr, fattr);
        nfs_post_op_update_inode_force_wcc_locked(inode, fattr);


I'm not sure if reverting this chuck is the correct solution but it
does fix the problem.


>
> Note that this happens independent of the minor version. For attribute
> delegation, the client's write completion logic sees the active
> delegation and skips updating the local file size.
>
> Seems like nfs4_opendata_find_nfs4_state() needs to recognize that an
> O_DIRECT OPEN cannot use cached open state that was created by a non
> O_DIRECT_OPEN ?? Or nfs4_set_rw_stateid() needs to recognize that an
> I/O is direct, and choose only an open state ID. But that means there
> needs to be a guarantee that an open state ID is available.
>
> Guidance would be appreciated.
>
>
> --
> Chuck Lever
>

