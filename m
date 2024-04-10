Return-Path: <linux-nfs+bounces-2744-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E9D89FC75
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CA81C2199A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAF172BC0;
	Wed, 10 Apr 2024 16:06:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cventin.lip.ens-lyon.fr (cventin.lip.ens-lyon.fr [140.77.13.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC741779AD
	for <linux-nfs@vger.kernel.org>; Wed, 10 Apr 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.13.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765217; cv=none; b=QS6o9gK7ZUiwQ1+OoB0FVRlqWvzz413MuBPM6TU7X/BAhiWlrkpsOW+kB1qQfExpLlRhrie4b1bgICQ7i8g9QTwRMTPg1xU2Rghfnzu4THriDcWgFWizHJmBGjwlLJRIOvt6HN4IuCUxQAheHZ6oi4UA6zgXvetIUF0e1f3iDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765217; c=relaxed/simple;
	bh=EiMb85fOO7POCiuPtPZNa9dtMWlF5eQ674L35rVsaT4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p4XkZCh4I2nBk7rHN6jhxPOpBEXtFkwqF9RKbW/ifuPDpoPPgRCZ6L4JXNAzB9BA5UhMr9oglQmvNWv0CkWDAcqFynh47f21Bqf/vLgrmROjznJqT7wlnZwGjO/ojDxV36aY0XIWqJvk8DO0pbT7d0+KBUJdBLxR2cmI/pj3fdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=140.77.13.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from vlefevre by cventin.lip.ens-lyon.fr with local (Exim 4.97)
	(envelope-from <vincent@vinc17.net>)
	id 1ruaLz-00000002gNx-2Cva;
	Wed, 10 Apr 2024 17:59:15 +0200
Date: Wed, 10 Apr 2024 17:59:15 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: linux-nfs@vger.kernel.org
Subject: [BUG] stat randomly fails with ENOENT, including on . and ..
Message-ID: <20240410155915.GG2068@cventin.lip.ens-lyon.fr>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.12+69 (354c5b11) vl-149028 (2023-12-10)

On Debian 12.5 machines (but the same problem occurred with Debian 11),
a "stat" or "open" sometimes fails with the "No such file or directory"
error message, though the file exists and was obtained with "readdir".
Note that the "stat" may succeed, but the "open" that comes just after
may fail. Said otherwise, it seems like the file suddenly disappears.

Note also that this can occur even on . or .. (see below), which are
supposed to always exist.

I could find that other users got the same kind of issue:

  https://bugzilla.redhat.com/show_bug.cgi?id=228801
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1017720

though I don't know whether the cause is the same.

The mount options are the following ones:

filer.lip.ens-lyon.fr:/tank/home/vlefevre on /home/vlefevre type nfs4 (rw,nosuid,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=140.77.14.11,local_lock=none,addr=140.77.14.38)

and the kernel version on this client machine:

Linux cassis 6.1.0-18-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.76-1 (2024-02-01) x86_64 GNU/Linux

If need be, I can get more information from the admins about the server.

But perhaps you can reproduce the problem with the simple Perl script
below. To be able to reproduce it, the directory needs to be recent (I
cannot reproduce the problem if I use an old directory, even if I add
files into it). I can reproduce the problem with an empty directory
(the fact that there are . and .. seems sufficient), but it is better
to add files, say with

  mkdir test && cd test && touch `seq 999`

The permissions of the directory and the files may be set to read-only.

Moreover, I cannot reproduce the problem with only one worker thread
($maxthreads = 1) or if I modify the script to use pre-existing threads
instead of creating a new thread for each file obtained by readdir.
And I cannot reproduce the problem with a local (non-NFS) directory
(with this machine or another one).

------------------------------------------------------------------------
#!/usr/bin/env perl

use strict;
use threads;

@ARGV == 1 || @ARGV == 2 or die "Usage: $0 <dir> [ <maxthreads> ]\n";
my ($dir,$maxthreads) = @ARGV;

-d $dir or die "$0: $dir is not a directory\n";

if (defined $maxthreads)
  {
    $maxthreads =~ /^\d+$/ && $maxthreads >= 1 && $maxthreads <= 32
      or die "$0: maxthreads must be an integer between 1 and 32\n";
  }
else
  {
    $maxthreads = 2;
  }

sub stat_test ($) {
  foreach my $i (1..100)
    {
      stat "$dir/$_[0]"
        or warn("$0: can't stat $_[0] ($!, i = $i)\n"), last;
    }
}

my $nthreads = 0;

sub join_threads () {
  my @thr;
  0 until @thr = threads->list(threads::joinable);
  foreach my $thr (@thr)
    { $thr->join(); }
  $nthreads -= @thr;
}

opendir DIR, $dir or die "$0: opendir failed ($!)\n";
while (my $file = readdir DIR)
  {
    $nthreads < $maxthreads or join_threads;
    $nthreads++ < $maxthreads or die "$0: internal error\n";
    threads->create(\&stat_test, $file);
  }
closedir DIR or die "$0: closedir failed ($!)\n";
join_threads while $nthreads;
------------------------------------------------------------------------

Example of failure:

$ strace -o str.out -f ./dir-stat2 test
./dir-stat2: can't stat . (No such file or directory, i = 16)
./dir-stat2: can't stat .. (No such file or directory, i = 56)
./dir-stat2: can't stat 5 (No such file or directory, i = 30)
./dir-stat2: can't stat 2 (No such file or directory, i = 72)
./dir-stat2: can't stat 8 (No such file or directory, i = 1)

Excerpt of the strace output:

[...]
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766650 brk(0x562c8a37d000 <unfinished ...>
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.",  <unfinished ...>
2766650 <... brk resumed>)              = 0x562c8a37d000
2766651 <... newfstatat resumed>{st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.",  <unfinished ...>
2766650 fchdir(4 <unfinished ...>
2766651 <... newfstatat resumed>{st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.", {st_mode=S_IFDIR|0755, st_size=11, ...}, 0) = 0
2766651 newfstatat(AT_FDCWD, "test/.",  <unfinished ...>
2766650 <... fchdir resumed>)           = 0
2766651 <... newfstatat resumed>0x562c8a0e7848, 0) = -1 ENOENT (No such file or directory)
2766651 write(2, "./dir-stat2: can't stat . (No su"..., 62 <unfinished ...>
[...]

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)

