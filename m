Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3572695A6
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 21:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgINT3h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 15:29:37 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:41664 "EHLO
        elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgINT3d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Sep 2020 15:29:33 -0400
X-Greylist: delayed 15994 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 15:29:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1600111772; bh=50CfdtKMy2s2iJAv5lGwzJfAQebbhpgJ8lf0
        rSlVNNU=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=dJLRnrgLMYH1tM8ukdWyvXL0OhjcvFTy0hmG9Gg7Tbihkd
        G1H0NT+J3g9+EJc6syhUf0+AqoIQswdcvBBD3Xx1OH+4eehxTldF3reBxzBWIyQje6Z
        Z/ZoT/v74poYQuiUDdh1/99mVBfFLfTOwpOQuXYrdb/qtPAyHDFQ7xTRkvO1TWGj5v3
        +THYziGcAAFU5bhupP4FY1dtQYELtXOenNcXoYwcFpZZeNJ6KaaXXL1VbZwLfTCU1tT
        KEBcCu1yLV+iH10o7weL1glFtoJ7gRNegS44GuzuMFO2VJIyMVwvQXr+lwcglAQkNg4
        cNbsLO5FIpvMdoIMQPquPAO4Z7xQ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=B8MXrJhiu11985C8/TrCW866UthzZfTkV41s66Xd1Zu5i2kq6hXfRz///4Tv5mc9ZCVbsv+KLqXLlpc4F4PuT7kJajxOHPeF4F80x/a+ybOLFqTe8Vxm09lkozJg9RGY8Qf5BTNt889IkVxaiLiT3oS7ZVJxJuLQFwbRBg01mdU+8QpfQ7T7qrIEYROYOOUM+ccXmggtOXoRouuzvsvi9pPRptYaIfBRE+N0W7P8GzB698xYmPL4X8uV9blqgY3hhOnxIcmIW7/wKNr4r6NCUE7fmBwKcTt172k4JmsyOSgzqz+ymJqgVb/HQn3oCwHoJ8jfjQGxc+G3uJL7oe7GDg==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kHq0M-0007nJ-9B; Mon, 14 Sep 2020 11:02:54 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Kinglong Mee'" <kinglongmee@gmail.com>,
        "'Anna Schumaker'" <schumaker.anna@gmail.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        <devel@lists.nfs-ganesha.org>, <linux-nfs@vger.kernel.org>
Cc:     "'Daniel Gryniewicz'" <dang@redhat.com>,
        "'gaurav gangalwar'" <gaurav.gangalwar@gmail.com>
References: <182fecd3-66c3-0cbd-fbc0-cf1a88b7f165@gmail.com> <182a9c6a29690fc00789768bdfe03affbac0db9e.camel@hammerspace.com> <53f12a27-e1f5-936f-23e9-58d3cbf7a00f@gmail.com> <6f906850076c15aedff11d721fe91d3279935224.camel@gmail.com> <00e301d44a26$12cd63d0$38682b70$@mindspring.com> <f096aead-c6d0-2768-8cf4-ebdf0f89c027@gmail.com> <012901d44a8f$ed7c6bc0$c8754340$@mindspring.com> <acda682b-fdc1-3e45-baef-03142bafb2f8@gmail.com>
In-Reply-To: <acda682b-fdc1-3e45-baef-03142bafb2f8@gmail.com>
Subject: RE: [NFS-Ganesha-Devel] Re: lseek gets bad offset from nfs client with ganesha/gluster which supports SEEK
Date:   Mon, 14 Sep 2020 08:02:52 -0700
Message-ID: <07fd01d68aa8$1f9f7110$5ede5330$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQGcG6Z0tHgxOmkJCJgy7Pk9/x8RoQH5KlHFASxcL+IBPC3iNgI95V0GAjQSzB0CiQWptgHaC2yEqXNicdA=
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4dce720942b735c4ed6fb9719a7f830cc0350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Has something changed in the RFC, the knfsd code, or the client with =
respect to seeking a hole at the end of file, particularly a legacy file =
that has no actual holes?

Thanks

Frank

> -----Original Message-----
> From: Kinglong Mee [mailto:kinglongmee@gmail.com]
> Sent: Wednesday, September 12, 2018 5:04 PM
> To: Frank Filz <ffilzlnx@mindspring.com>; 'Anna Schumaker'
> <schumaker.anna@gmail.com>; 'Trond Myklebust'
> <trondmy@hammerspace.com>; devel@lists.nfs-ganesha.org; linux-
> nfs@vger.kernel.org
> Subject: [NFS-Ganesha-Devel] Re: lseek gets bad offset from nfs client =
with
> ganesha/gluster which supports SEEK
>=20
> On 2018/9/12 19:58, Frank Filz wrote:
> >> On 2018/9/12 7:20, Frank Filz wrote:
> >>>> On Tue, 2018-09-11 at 22:47 +0800, Kinglong Mee wrote:
> >>>>> On 2018/9/11 20:57, Trond Myklebust wrote:
> >>>>>> On Tue, 2018-09-11 at 20:29 +0800, Kinglong Mee wrote:
> >>>>>>> The latest ganesha/gluster supports seek according to,
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> =
https://tools.ietf.org/html/draft-ietf-nfsv4-minorversion2-41#sec
> >>>>>> ti
> >>>>>> o
> >>>>>> n-15.11
> >>>>>>>
> >>>>>>>    From the given sa_offset, find the next data_content4 of =
type
> >>>>>>> sa_what
> >>>>>>>    in the file.  If the server can not find a corresponding =
sa_what,
> >>>>>>>    then the status will still be NFS4_OK, but sr_eof would be
> >>>>>>> TRUE.  If
> >>>>>>>    the server can find the sa_what, then the sr_offset is the
> >>>>>>> start of
> >>>>>>>    that content.  If the sa_offset is beyond the end of the
> >>>>>>> file, then
> >>>>>>>    SEEK MUST return NFS4ERR_NXIO.
> >>>>>>>
> >>>>>>> For a file's filemap as,
> >>>>>>>
> >>>>>>> Part    1: HOLE 0x0000000000000000 ---> 0x0000000000600000
> >>>>>>> Part    2: DATA 0x0000000000600000 ---> 0x0000000000700000
> >>>>>>> Part    3: HOLE 0x0000000000700000 ---> 0x0000000001000000>>
> >>>>>>> SEEK(0x700000, SEEK_DATA) gets result (sr_eof:1,
> >>>>>>> sr_offset:0x70000) from ganesha/gluster; SEEK(0x700000,
> >>>>>>> SEEK_HOLE) gets result (sr_eof:0, sr_offset:0x70000) from
> ganesha/gluster.
> >>>>>>>
> >>>>>>> If an application depends the lseek result for data searching,
> >>>>>>> it may enter infinite loop.
> >>>>>>>
> >>>>>>>         while (1) {
> >>>>>>>                 next_pos =3D lseek(fd, cur_pos, seek_type);
> >>>>>>>                 if (seek_type =3D=3D SEEK_DATA) {
> >>>>>>>                         seek_type =3D SEEK_HOLE;
> >>>>>>>                 } else {
> >>>>>>>                         seek_type =3D SEEK_DATA;
> >>>>>>>                 }
> >>>>>>>
> >>>>>>>                 if (next_pos =3D=3D -1) {
> >>>>>>>                         return ;
> >>>>>>>
> >>>>>>>                 cur_pos =3D next_pos;
> >>>>>>>         }
> >>>>>>>
> >>>>>>> The lseek syscall always gets 0x70000 from nfs client for =
those
> >>>>>>> two cases, but, if underlying filesystem is ext4/f2fs, or the
> >>>>>>> nfs server is knfsd, the lseek(0x700000, SEEK_DATA) gets =
ENXIO.
> >>>>>>>
> >>>>>>> I wanna to know,
> >>>>>>> should I fix the ganesha/gluster as knfsd return ENXIO for the
> >>>>>>> first case?
> >>>>>>> or should I fix the nfs client to return ENXIO for the first =
case?
> >>>>>>>
> >>>>>>
> >>>>>> It that test correct? The fallback implementation of SEEK_DATA
> >>>>>> assumes that the entire file is data, so lseek(SEEK_DATA) on =
any
> >>>>>> offset that is <=3D eof will be a no-op. The fallback
> >>>>>> implementation of SEEK_HOLE assumes that the first hole is at =
eof.
> >>>>>
> >>>>> I think that's non-nfsv4.2's logical.
> >>>>>
> >>>>>>
> >>>>>> IOW: unless the initial value for cur_pos is > eof, it looks to
> >>>>>> me as if the above test will loop infinitely given any =
filesystem
> >>>>>> that doesn't implement native support for SEEK_DATA/SEEK_HOLE.
> >>>>>>
> >>>>>
> >>>>> No, if underlying filesystem is ext4/f2fs, or the nfs server is
> >>>>> knfsd, the last lseek syscall always return ENXIO no matter the
> >>>>> cur_pos is > eof or not.
> >>>>>
> >>>>> A file ends with a hole as,
> >>>>> Part   22: DATA 0x0000000006a00000 ---> 0x0000000006afffff
> >>>>> Part   23: HOLE 0x0000000006b00000 ---> 0x000000000c7fffff
> >>>>>
> >>>>> # stat testfile
> >>>>>   File: testfile
> >>>>>   Size: 209715200       Blocks: 22640      IO Block: 4096   =
regular file
> >>>>> Device: 807h/2055d      Inode: 843122      Links: 2
> >>>>> Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/  =
  root)
> >>>>> Access: 2018-09-11 20:01:41.881227061 +0800
> >>>>> Modify: 2018-09-11 20:01:41.976478311 +0800
> >>>>> Change: 2018-09-11 20:01:41.976478311 +0800
> >>>>>  Birth: -
> >>>>>
> >>>>> # strace filemap testfile
> >>>>> ... ...
> >>>>> lseek(3, 111149056, SEEK_HOLE)          =3D 112197632
> >>>>> lseek(3, 112197632, SEEK_DATA)          =3D -1 ENXIO (No such =
device or
> >> address)
> >>>>>
> >>>>> Right now, when knfsd gets the ENXIO error, it returns the error
> >>>>> to client directly, and return to syscall.
> >>>>> But, ganesha set the sr_eof to true and return NFS4_OK to client
> >>>>> as RFC description, nfs client skips the sr_eof and return a bad
> >>>>> offset to syscall.
> >>>>
> >>>> Would it make more sense to change Knfsd instead of the client?  =
I
> >>>> think I was trying to keep things simple when I wrote the code, =
so
> >>>> I just passed the result of the lseek system call back to the =
client.
> >>>
> >>> Looking at the lseek(2) man page, it's not clear to me what should
> >>> be returned
> >> if as in this example, there is a HOLE at the end of the file (i.e.
> >> filesize is larger than the range of the last DATA in the file). It
> >> sounds like ext4 returns ENXIO if a SEEK_DATA is done past the last =
data in
> the file.
> >>>
> >>>        SEEK_DATA
> >>>               Adjust the file offset to the next location in the
> >>> file greater than or
> >> equal to offset containing data.  If offset points to data, then =
the
> >> file offset  is set
> >>>               to offset.
> >>>
> >>>        SEEK_HOLE
> >>>               Adjust  the file offset to the next hole in the file
> >>> greater than or equal
> >> to offset.  If offset points into the middle of a hole, then the =
file
> >> offset is set to
> >>>               offset.  If there is no hole past offset, then the
> >>> file offset is adjusted to
> >> the end of the file (i.e., there is an implicit hole at the end of =
any file).
> >>>
> >>>        In both of the above cases, lseek() fails if offset points
> >>> past the end of the
> >> file.
> >>>
> >>>        These operations allow applications to map holes in a
> >>> sparsely allocated
> >> file.  This can be useful for applications such as file backup =
tools,
> >> which can save space when
> >>>        creating backups and preserve holes, if they have a =
mechanism
> >>> for
> >> discovering holes.
> >>>
> >>>        For the purposes of these operations, a hole is a sequence =
of
> >>> zeros that
> >> (normally) has not been allocated in the underlying file storage.
> >> However, a filesystem is not
> >>>        obliged to report holes, so these operations are not a
> >>> guaranteed
> >> mechanism for mapping the storage space actually allocated to a =
file.
> >> (Furthermore,  a  sequence  of
> >>>        zeros  that actually has been written to the underlying
> >>> storage may not be
> >> reported as a hole.)  In the simplest implementation, a filesystem
> >> can support the operations
> >>>        by making SEEK_HOLE always return the offset of the end of
> >>> the file, and
> >> making SEEK_DATA always return offset (i.e., even if the location
> >> referred to by offset  is  a
> >>>        hole, it can be considered to consist of data that is a =
sequence of zeros).
> >>>
> >>> The RFC text is pretty clear:
> >>>
> >>>    SEEK is an operation that allows a client to determine the =
location
> >>>    of the next data_content4 in a file.  It allows an =
implementation of
> >>>    the emerging extension to lseek(2) to allow clients to =
determine the
> >>>    next hole whilst in data or the next data whilst in a hole.
> >>>
> >>>    From the given sa_offset, find the next data_content4 of type =
sa_what
> >>>    in the file.  If the server can not find a corresponding =
sa_what,
> >>>    then the status will still be NFS4_OK, but sr_eof would be =
TRUE.  If
> >>>    the server can find the sa_what, then the sr_offset is the =
start of
> >>>    that content.  If the sa_offset is beyond the end of the file, =
then
> >>>    SEEK MUST return NFS4ERR_NXIO.
> >>>
> >>>    All files MUST have a virtual hole at the end of the file.  =
I.e., if
> >>>    a filesystem does not support sparse files, then a compound =
with
> >>>    {SEEK 0 NFS4_CONTENT_HOLE;} would return a result of {SEEK 1 =
X;}
> >>>    where 'X' was the size of the file.
> >>>
> >>> Sa_offset is not past the end of the file, but there is no more
> >>> DATA, so a seek
> >> DATA from 0x70000 (original file) should return sr_eof TRUE.
> >>>
> >>> In either RFC or lseek(2), a seek HOLE for 0x70000 will return =
0x70000.
> >>>
> >>> It certainly makes sense that you should be able to have a hole at
> >>> the end of a
> >> file (pre-allocated disk blocks but no data written yet), and is in
> >> fact what
> >> fallocate(2) will do.
> >>>
> >>> An NFS server could check the filesize and if sa_offset is <
> >>> filesize and a
> >> SEEK_DATA returns ENXIO, it could translate that to NFS4_OK and set
> >> sr_eof to TRUE.
> >>>
> >>> The Ganesha code in FSAL_GLUSTER I believe is wrong. It changes =
any
> >>> ENXIO
> >> result to NFS4_OK with sr_eof TRUE. It would be better for it to do
> >> the simple thing knfsd does of always passing along the ENXIO (this
> >> may be best if it is not possible to safely verify sa_offset really =
is < filesize).
> >>
> >> Do you mean modifying ganesha/gluster as knfsd does?
> >>
> >>         seek->seek_pos =3D vfs_llseek(file, seek->seek_offset, =
whence);
> >>         if (seek->seek_pos < 0)
> >>                 status =3D nfserrno(seek->seek_pos);
> >>         else if (seek->seek_pos >=3D i_size_read(file_inode(file)))
> >>                 seek->seek_eof =3D true;
> >>
> >> It is a working implementation, but not according to RFC =
description,
> >>
> >>    If the server can not find a corresponding sa_what,
> >>    then the status will still be NFS4_OK, but sr_eof would be TRUE.
> >>
> >> As in this example, there is a HOLE at the end of the file, SEEK(in
> >> hole,
> >> SEEK_DATA) should return NFS4_OK and sr_eof is TRUE, but knfsd =
return
> >> NFS4ERR_NXIO.
> >
> > FSAL_GLUSTER always translates lseek return of ENXIO to NFS4_Ok with
> sr_eod TRUE.
> >
> > It should at least ONLY do that if sa_offset is < filesize (which =
would then be
> correct per RFC).
> >
> > Knfsd, to my understanding, looks like it always just returns ENXIO =
(which isn't
> exactly per RFC, but at least doesn't confuse the client and =
application as badly).
> >
>=20
> Copy that.
> I will push a fix as knfsd.
>=20
> thanks,
> Kinglong Mee
> _______________________________________________
> Devel mailing list -- devel@lists.nfs-ganesha.org To unsubscribe send =
an email to
> devel-leave@lists.nfs-ganesha.org

