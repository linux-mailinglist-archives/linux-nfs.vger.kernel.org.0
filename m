Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6B3DB1DA
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jul 2021 05:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhG3DPq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jul 2021 23:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhG3DPp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jul 2021 23:15:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D1C061765
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 20:15:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j2so10951663edp.11
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 20:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=BXLmVOsspHuUGI5eQSDVQgFg5AOQTINIhyo3H+MZZ9Q=;
        b=JLXQkwwYC+JDr4zDcCeK5G6tEXTBUp+AOEmNqUk9qoVOM+d3fx1KWMo1GC5Ezzay3t
         zp25IwZJaFOF3ZA+u70OR85HZYOJdjZu3fgryaz/AkkTPYEiRmfmPEBwk6Gee4xv1/TT
         DRju8c0XayhuBO0fGBuYvqBn2RJq2gC5SXmt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BXLmVOsspHuUGI5eQSDVQgFg5AOQTINIhyo3H+MZZ9Q=;
        b=iUO98/IiS50gaZdXTX+6YWt9OGDXKeN80A3JuXIHM0lFgAPFV7vLsfF0AJdBnuqu1P
         Hy5RnhW8x+7tipr39NlfM07rkrdeQ8hyLj2LWpKyxknjJhYlEMFjMbKlf1XyPvfa0r9K
         IwDJQeMG/2KXYhfoJlwBdNyMZaDnqP0QrhQDHBsAvBP88dusWEyMW27Cb55sOnV1BhLv
         Dhc3Gcj85CQ+iDX8njRjQztGq5SZxjFVZBXwBrZV2jAmCk/F1PInxpyp808JU8szIC4g
         cuXugCWUvSDY8Y/NWY0kXtmJuAzZ3tdInqmg+RLkjqnEC4thUutQsoGmu9QoPJBEB+Bw
         80vw==
X-Gm-Message-State: AOAM5317AAqXhsjhrf/CGOK22ZbP4MtYV14iRBX4phQP3haA8Nf2CG7U
        mopqwoEKpdoYp9cvg5W/dIBcet9RVKQSQDQYPcLqqVmsEOb2Qw==
X-Google-Smtp-Source: ABdhPJz9SiIy44au93i/wT99TSYu0/xe3zKhuTEuP0yPuIDT8exdKnrseJt0iUG7lIfKaYdmjFqJybDB2TkViGdUIsE=
X-Received: by 2002:a05:6402:5212:: with SMTP id s18mr388872edd.370.1627614938950;
 Thu, 29 Jul 2021 20:15:38 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Robertson <mrobertson@purestorage.com>
Date:   Thu, 29 Jul 2021 22:15:27 -0500
Message-ID: <CAKYZyzdfnVtwup-Cz1fX1OsNe-SdTQaLePoj05d3nGDVL6yfaw@mail.gmail.com>
Subject: NFSv4.1 - 2x opens causes unknown 5s delay.
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Doing a simple open of a file from 2 readers and there is a strange 5s
delay on the second open.   We did NOT see the issue on kernel:
CentOS 4.18.0-193.6.3.el8_2.x86_64
but the issue is present in:
CentOS 4.18.0-305.7.1.el8_4.x86_64


#include <stdio.h>

int main() {

        FILE * file_pointer;

        char buffer[50], c;

file_pointer = fopen("/mnt/nfsv4/test/t.txt", "r");

fgets(buffer, 50, file_pointer);

file_pointer = fopen("/mnt/nfsv4/test/t.txt", "r");

fgets(buffer, 50, file_pointer);

        fclose(file_pointer);

return 0;

}



Call Graph from ftrace

_nfs4_opendata_to_nfs4_state()

 nfs_refresh_inode() {

  nfs_refresh_inode.part.28() {

   nfs_refresh_inode_locked() {

 update_open_stateid()

  ** 5s wait **

Then the open / read completes


We do not see this issue on nfsv3 only nfsv4.


Here is the wireshark of the request and response:

The second request and response happens immediately in the wireshark.
The delay is in the kernel.



Frame 25: 378 bytes on wire (3024 bits), 378 bytes captured (3024 bits)
Ethernet II, Src: fa:16:3e:88:e2:24 (fa:16:3e:88:e2:24), Dst:
PureStor_5b:45:10 (24:a9:37:5b:45:10)
Internet Protocol Version 4, Src: 10.15.132.250, Dst: 10.15.128.15
Transmission Control Protocol, Src Port: 710, Dst Port: 2049, Seq:
2125, Ack: 1193, Len: 312
Remote Procedure Call, Type:Call XID:0xed175b8d
Network File System, Ops(5): SEQUENCE, PUTFH, OPEN, ACCESS, GETATTR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
    minorversion: 1
    Operations (count: 5): SEQUENCE, PUTFH, OPEN, ACCESS, GETATTR
        Opcode: SEQUENCE (53)
            sessionid: 00c800000000000c0000000000000000
            seqid: 0x00000073
            slot id: 0
            high slot id: 0
            cache this?: Yes
        Opcode: PUTFH (22)
            FileHandle
        Opcode: OPEN (18)
            seqid: 0x00000000
            share_access: OPEN4_SHARE_ACCESS_READ (1)
            share_deny: OPEN4_SHARE_DENY_NONE (0)
            clientid: 0x00c8000000000017
            owner: <DATA>
            Open Type: OPEN4_NOCREATE (0)
            Claim Type: CLAIM_FH (4)
        Opcode: ACCESS (3), [Check: RD MD XT XE]
            Check access: 0x2d
                .... ...1 = 0x001 READ: allowed?
                .... .1.. = 0x004 MODIFY: allowed?
                .... 1... = 0x008 EXTEND: allowed?
                ..1. .... = 0x020 EXECUTE: allowed?
        Opcode: GETATTR (9)
            Attr mask[0]: 0x0010011a (Type, Change, Size, FSID, FileId)
                reqd_attr: Type (1)
                reqd_attr: Change (3)
                reqd_attr: Size (4)
                reqd_attr: FSID (8)
                reco_attr: FileId (20)
            Attr mask[1]: 0x0030a23a (Mode, NumLinks, Owner,
Owner_Group, RawDev, Space_Used, Time_Access, Time_Metadata,
Time_Modify)
                reco_attr: Mode (33)
                reco_attr: NumLinks (35)
                reco_attr: Owner (36)
                reco_attr: Owner_Group (37)
                reco_attr: RawDev (41)
                reco_attr: Space_Used (45)
                reco_attr: Time_Access (47)
                reco_attr: Time_Metadata (52)
                reco_attr: Time_Modify (53)
    [Main Opcode: OPEN (18)]





Frame 26: 374 bytes on wire (2992 bits), 374 bytes captured (2992 bits)
Ethernet II, Src: PureStor_5b:45:10 (24:a9:37:5b:45:10), Dst:
fa:16:3e:88:e2:24 (fa:16:3e:88:e2:24)
Internet Protocol Version 4, Src: 10.15.128.15, Dst: 10.15.132.250
Transmission Control Protocol, Src Port: 2049, Dst Port: 710, Seq:
1193, Ack: 2437, Len: 308
Remote Procedure Call, Type:Reply XID:0xed175b8d
Network File System, Ops(5): SEQUENCE PUTFH OPEN ACCESS GETATTR
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
    Operations (count: 5)
        Opcode: SEQUENCE (53)
            Status: NFS4_OK (0)
            sessionid: 00c800000000000c0000000000000000
            seqid: 0x00000073
            slot id: 0
            high slot id: 127
            target high slot id: 127
            status flags: 0x00000000
        Opcode: PUTFH (22)
            Status: NFS4_OK (0)
        Opcode: OPEN (18)
            Status: NFS4_OK (0)
            StateID
                [StateID Hash: 0xaa04]
                StateID seqid: 1
                StateID Other: 000000000000000000000000
                [StateID Other hash: 0x60de]
            change_info
                Atomic: Yes
                changeid (before): 1626267251187000000
                changeid (after): 1626267251187000000
            result flags: 0x00000004, locktype posix
            Delegation Type: OPEN_DELEGATE_NONE (0)
        Opcode: ACCESS (3), [NOT Supported: LU DL], [Access Denied: LU
MD XT DL XE], [Allowed: RD]
            Status: NFS4_OK (0)
            Supported types (of requested): 0x3f
            Access rights (of requested): 0x01
                .... ...1 = 0x001 READ: allowed
                .... ..0. = 0x002 LOOKUP: *Access Denied*
                .... .0.. = 0x004 MODIFY: *Access Denied*
                .... 0... = 0x008 EXTEND: *Access Denied*
                ...0 .... = 0x010 DELETE: *Access Denied*
                ..0. .... = 0x020 EXECUTE: *Access Denied*
        Opcode: GETATTR (9)
            Status: NFS4_OK (0)
            Attr mask[0]: 0x0010011a (Type, Change, Size, FSID, FileId)
                reqd_attr: Type (1)
                    ftype4: NF4REG (1)
                reqd_attr: Change (3)
                    changeid: 1626267251187000000
                reqd_attr: Size (4)
                    size: 7
                reqd_attr: FSID (8)
                    fattr4_fsid
                reco_attr: FileId (20)
                    fileid: 20829148276664444
            Attr mask[1]: 0x0030a23a (Mode, NumLinks, Owner,
Owner_Group, RawDev, Space_Used, Time_Access, Time_Metadata,
Time_Modify)
                reco_attr: Mode (33)
                    mode: 0644, Name: Unknown, Read permission for
owner, Write permission for owner, Read permission for group, Read
permission for others
                reco_attr: NumLinks (35)
                    numlinks: 1
                reco_attr: Owner (36)
                    fattr4_owner: 0
                reco_attr: Owner_Group (37)
                    fattr4_owner_group: 0
                reco_attr: RawDev (41)
                    specdata1: 0
                    specdata2: 0
                reco_attr: Space_Used (45)
                    space_used: 7
                reco_attr: Time_Access (47)
                    seconds: 1626267228
                    nseconds: 0
                reco_attr: Time_Metadata (52)
                    seconds: 1626267251
                    nseconds: 187000000
                reco_attr: Time_Modify (53)
                    seconds: 1626267251
                    nseconds: 186841000
    [Main Opcode: OPEN (18)]


-- 
Matt Robertson // Data Architect | Pure Storage, Inc.
913-915-1162  |  mrobertson@purestorage.com
