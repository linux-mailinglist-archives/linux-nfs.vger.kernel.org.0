Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDCD1DC565
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgEUCz5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 22:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgEUCzz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 22:55:55 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 May 2020 19:55:55 PDT
Received: from smtp.dropbear.xyz (constantine.dropbear.xyz [IPv6:2001:19f0:5801:2cd::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B157C061A0E
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 19:55:55 -0700 (PDT)
Date:   Thu, 21 May 2020 12:30:55 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=dropbear.xyz;
        s=202004; t=1590029281;
        bh=YVW2gUVoevwFC/+ukgxl6vUHcq+TTqUd8my3OBObEPw=;
        h=Date:From:To:Subject:From;
        b=qIqic1OtmgHDA3fj1bSZAszzvTlL3C/xCeU1RfKl8HLKNmltFZ2XYKWJMddWRKIFL
         j18p0VI0sVvA2LI8IeJffR7DLwXVLYX8KuI/+QwVhGHUVCYeU5gZMvqRKHxImFi2fk
         LnPMq71cAYMLAO7jKJNlWQ2YKFVkxCEvu96+Gxjk=
From:   Craig Small <csmall@dropbear.xyz>
To:     linux-nfs@vger.kernel.org
Subject: How to separate NFS mounts have same device ID
Message-ID: <20200521023055.GA1246587@dropbear.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,
  I'm the author of the psmisc programs that include things like killall and fuser.  I have a problem with finding files open on NFS mounts from the same server.  The issue is at https://gitlab.com/psmisc/psmisc/-/issues/10

The way fuser does its job is to find the mounts you specify and collect the device IDs, then scans all /proc/<PID/fd/* for matching devices. However, NFS mounts from the same server have the same device ID so fuser reports every mount has the same file opened.

Putting it another way, if I said "here is file /proc/<PID>/fd/3, dereference the symlink and tell me which of these two NFS mounts from the same server it comes from?" how would you do it?
A simple string match (/mnt/a vs /mnt/b) does not work because you can have symlinks across mounts.

Any help here would be appreciated. I'm not subscribed to the list so hopefully, this makes it through whatever filters there are and please CC me on replies.

 - Craig

