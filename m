Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C772832C6CA
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451107AbhCDAaA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353613AbhCDAFN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 19:05:13 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D3C061760
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 16:00:34 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z9so12847265iln.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Mar 2021 16:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=INn4N7TSacThyy6y9bvC2AzMj4/LZgFs6XrxoTSw1sg=;
        b=S2cVInFEaRt1ylgS5jhHEQASul1sj7qeTIk7YVjpeTWrxMb7BMmqiu1tqkiD2D0/+O
         DFaUpvmg8fOfHk/rsIdMDxGcCw1mJZp2JDUOlLEY5gP8B0PxjG3VF1D5jNyQJaUivtg+
         NI2Mod8Iv45BmBw42+NuG755uDQ/KZIe9lRB1bgN8gYUVPj/1WwEdEVRmPmOTXgFI+Kj
         fwZDjggYfK+N/stGASYgX2ZZl2E/+LDszeXiumLqojqehTV5IasswpG496UB1Ucjftrw
         ejkrtFd1qEC93fKbOQpfPUpWxG5ZVrFuPpuC+skxn/JclIZgCxrgHmMiPC2Nfvl2Smi8
         DNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=INn4N7TSacThyy6y9bvC2AzMj4/LZgFs6XrxoTSw1sg=;
        b=ql6j6ypFRkfOUzEgxhUV5ekwyYfSBQGDCeyF/nQzx6f8kOYuDVZZ1sxr8P0GffCBIe
         cc1HVoFBKDzZ0d9uJwwBBuv4gBUac2PS+k8EpPtVarfLQP2I+AcQ4+8vlkACUiLMdNgI
         L61FZKtzh6j7uEHR+4KdyNiXGalfy4g5XNDKJWtBF0Cs3wIMaBHh0j2IdnIUqjsS7Mto
         Y5gN0+vGfoerXOLY1A/Q8A/PtIw1FBvkBcw9Dy86ondOBrZlZBojILIBfuoYWxzRJxeD
         sENZjDwSZ5+JAG+3fX+YS4a6kxfQJCRnHOB37VAP9tV4otedRGPBJxVyUcsMXiwxlNCh
         dtBQ==
X-Gm-Message-State: AOAM531W3zvKPfb8PlmNpBwgaLKKCjy5nHePq44vxZWZyI7HEl4gt+FP
        sFgIEdDFX10VqHKkMUVr3sFMi1Rtc/WSAxEE8PyZzGgfV/sBig==
X-Google-Smtp-Source: ABdhPJzygbOCE4IfJY/kiolM2s00W6NjD30JpL54WrNUTkqM7yWhXiNm0jJidF18GSb6pQFfTLUg0lybC6J/T9U33OM=
X-Received: by 2002:a05:6e02:1154:: with SMTP id o20mr1734053ill.236.1614816033855;
 Wed, 03 Mar 2021 16:00:33 -0800 (PST)
MIME-Version: 1.0
From:   Prasanna T R <prasannabanumathi@gmail.com>
Date:   Wed, 3 Mar 2021 17:00:23 -0700
Message-ID: <CAJBpUND1UHkHzvE_nhX2bhT3MiT-DModyC2CUc54MGV0xTBDSA@mail.gmail.com>
Subject: Concurrent non-overlapping pwrite() to a file on storage mounted on
 NFS using multiple MPI processes
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear all,

I am sorry for reposting this verbatim from stack overflow, but I need
help understanding what is going on. I have a computational fluid
dynamic code where I am coding a parallel read and write
implementation. What I want to achieve is for multiple MPI processes
to open the same file and write data to it (there is no overlap of
data, I use pwrite() with offset information). This seems to be
working fine when the two MPI processes are on the same computing
node. However, when I use 2 or more computing nodes, some of the data
does not reach the hard-drive (there are holes in the files) and I
suspect this has something to do with NFS. To demonstrate this, I have
written the following example C program which I compile using mpicc
(my MPI distribution is MPICH):
```
#include <mpi.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

long _numbering(long i,long j,long k, long N) {
  return (((i-1)*N+(j-1))*N+(k-1));
}

int main(int argc, char **argv)
{
  int   numranks, rank,fd,dd;
  long i,j,k,offset,N;
  double value=1.0;
  MPI_Init(NULL,NULL);
  MPI_Comm_size(MPI_COMM_WORLD, &numranks);
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);
  N=10;
  offset=rank*N*N*N*sizeof(double);
  fd=-1;
  printf("Opening file datasetparallel.dat\n");
  //while(fd==-1) {fd = open("datasetparallel.dat", O_RDWR | O_CREAT |
O_SYNC,0666);}
  while(fd==-1) {fd = open("datasetparallel.dat", O_RDWR | O_CREAT,0666);}
  //while(dd==-1) {fd = open("/homeA/Desktop/", O_RDWR ,0666);}

  for(i=1;i<=N;i++) {
    for(j=1;j<=N;j++) {
      for(k=1;k<=N;k++) {
        if(pwrite(fd,&value,sizeof(double),_numbering(i,j,k,N)*sizeof(double)+offset)!=8)
perror("datasetparallel.dat");
        //pwrite(fd,&value,sizeof(double),_numbering(i,j,k,N)*sizeof(double)+offset);
        value=value+1.0;
      }
    }
  }
  //if(close(fd)==-1) perror("datasetparallel.dat");
  fsync(fd); //fsync(dd);
  close(fd); //close(dd);

  printf("Done writing in parallel\n");
  if(rank==0) {
    printf("Beginning serial write\n");
    int ranknum;
    fd=-1;
    value=1.0;
    while(fd==-1) {fd = open("datasetserial.dat", O_RDWR | O_CREAT,0666);}
    for(ranknum=0;ranknum<numranks;ranknum++){
      offset=ranknum*N*N*N*sizeof(double); printf("Offset for rank %d
is %ld\n",ranknum,offset);
      printf("writing for rank=%d\n",ranknum);
      for(i=1;i<=N;i++) {
        for(j=1;j<=N;j++) {
          for(k=1;k<=N;k++) {
            if(pwrite(fd,&value,sizeof(double),_numbering(i,j,k,N)*sizeof(double)+offset)!=8)
perror("datasetserial.dat");
            //pwrite(fd,&value,sizeof(double),_numbering(i,j,k,N)*sizeof(double)+offset);
            value=value+1.0;
          }
        }
      }
      value=1.0;
    }
    //if(close(fd)==-1) perror("datasetserial.dat");
    fsync(fd);
    close(fd);
    printf("Done writing in serial\n");
  }
  MPI_Finalize();
  return 0;
}
```
The above program writes doubles in ascending sequence to a file. Each
MPI process writes the same numbers(1.0 to 1000.0) but to different
regions of the file. For example, rank 0 writes 1.0 to 1000.0, and
rank 1 writes 1.0 to 1000.0 beginning from the location just after
rank 0 wrote 1000.0 . The program outputs a file named
datasetparallel.dat which has been written through concurrent
pwrite()s. It also outputs datasetserial.dat for reference to compare
with the datasetparallel.dat file to check its integrity (I do this by
using the cmp command in the terminal). When a discrepancy is found
using cmp, I check the contents of the files using the od command:
```
od -N <byte_number> -tfD <file_name>
```
For example, I found some missing data (holes in the file) using the
above program. In the parallelly written file, the output using `od`
command :
```
.
.
.
0007660                      503                      504
0007700                      505                      506
0007720                      507                      508
0007740                      509                      510
0007760                      511                      512
0010000                        0                        0
*
0010620                        0
0010624
```
while in the reference file written in serial, the output from the `od` command:
```
.
.
.
0007760                      511                      512
0010000                      513                      514
0010020                      515                      516
0010040                      517                      518
0010060                      519                      520
0010100                      521                      522
0010120                      523                      524
0010140                      525                      526
0010160                      527                      528
0010200                      529                      530
0010220                      531                      532
0010240                      533                      534
0010260                      535                      536
0010300                      537                      538
0010320                      539                      540
0010340                      541                      542
0010360                      543                      544
0010400                      545                      546
0010420                      547                      548
0010440                      549                      550
0010460                      551                      552
0010500                      553                      554
0010520                      555                      556
0010540                      557                      558
0010560                      559                      560
0010600                      561                      562
0010620                      563                      564
.
.
.
```
So far, one of the few ways to fix the issue seems to be to use the
POSIX open() function with the O_SYNC flag, which ensures that file is
written physically to the hard drive, but this seems to be
impractically slow. A second way seems to be to call fsync() after
each write() which is also slow. An ever slower approach seems to be
using the MPI I/O/ ROMIO commands. The storage has been mounted on NFS
using the following flags:
`rw,nohide,insecure,no_subtree_check,sync,no_wdelay` . For performance
reasons, I have tried calling fsync() on the file and the directory
just before close(), but this doesn't seem to work. Thus, I need
advice on understanding why there are holes in the files and if there
is a way to fix this.

Sincerely,
Prasanna
