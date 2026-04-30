Return-Path: <linux-nfs+bounces-21317-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GVmNKjA82mw6gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21317-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 22:50:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AEF4A7EFF
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B7430C12C4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BB3AEF29;
	Thu, 30 Apr 2026 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vo8n7oKq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669363A2541;
	Thu, 30 Apr 2026 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581923; cv=none; b=bV0C+PECC+COw+Gmtb7XuMJpicPLt6sEEuS8oxxfpumEaNmxeNlKmiUfayk74TWlZkwYtCJ2xNCIUthYEUDtOMUGrbPT4HgV0WWsw5W08MjjM0vETovyNU6mdH9iejNt797l40FexHqJ1aFIStZ7fj33PtXTcdujn+TMCegUkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581923; c=relaxed/simple;
	bh=PMD1m8ve4xKUV7/vbspyzFVo9cbcLj+E/DWNXZdhXXs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ltfdqTLVTu+W1mzRJN4VzZlfPC5pRPqBeyw96PNdVNWDD25dAnGWS7PpjGu1zXs7rLWbHLfzk94mfpGLeDpesrw216l0bYOG+jFU6F/RjJveU6h6hyfu5bQ2+5DiU2UyHZPcpHkNVkSFictHPeFlXE16LeUkAXJ0knqQJJW6LBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vo8n7oKq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UD3Rk33705253;
	Thu, 30 Apr 2026 20:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LxlsDC
	Pbk5nrJThYGzKFK+MQapHguzs7Sw7YgjsguBg=; b=Vo8n7oKqRtNOAkNs3Q74Pv
	FnfgXIyWIoHgRwpb/KcWfDqoME5NiNsJVuGmbPAovyFqMp3r0uOMaCM7wUwpDnPb
	hS8H2VJhQMOUoHkrC0K7u2PUU5tsKcJO4shKAISe/+lu5FqTIGWXXYzOZ6u/cErj
	T4phxPgt8f4MTbHJK1qSe5VgZnEgPHQ3M5yTdL727OYQoU8khkW2kqvpOvMsDE9l
	AVzjxYOZNwOYq7YjjCgmJRyETimkVZYwa5rpGsT5VSrFfHmkBr+wyYyK5Gk0D2CO
	y7lByTOoS6SPXWhG9NVGu7PSFTES6eDYapshL65Uy+5fMEhWbxkMxeAWuPCoBuJg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e82sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 20:45:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UKQpoT024912;
	Thu, 30 Apr 2026 20:45:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqmvc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 20:45:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UKj57364946596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 20:45:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8A3F5804B;
	Thu, 30 Apr 2026 20:45:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3EE858055;
	Thu, 30 Apr 2026 20:45:04 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 20:45:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 May 2026 02:15:04 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Nfs
 <linux-nfs@vger.kernel.org>
Cc: Linuxppc Dev <linuxppc-dev@lists.ozlabs.org>, chuck.lever@oracle.com,
        jlayton@kernel.org, venkat88@linux.ibm.com,
        Linux Next
 <linux-next@vger.kernel.org>
Subject: Re: [BUG] [powerpc] [next-20260216/17] nfsd: use-after-free in
 cache_check_rcu() triggered by sosreport on ppc64le
In-Reply-To: <dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com>
References: <dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com>
Message-ID: <8cf80f450085ac17164e8fa1391e9635@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0RoD0pb4a8KTAtH2gJTH6H6lCGjbvlEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMCBTYWx0ZWRfXziEEMVF6Mour
 nqs75ZxpAhjCsinhop28xGOP0vs49jw2pDzsRpm1TJxOtbfDyLorqGfHONE9a2FRDvftejRIgcV
 EKWgPowJLdhPWS2ifzCJjIJ6xSyQeX1nrNmZim+/eM7s+UIwGxNSI1y6Nw9ree+d5WXHwh63lbM
 LekfZx+vEHgcVxroUjU5oul4SinfHJDv0unPOSev013+hAqpyvz2ieQkFjOFD8C4kopgejMMq8s
 aZefHjpszpOvLt/ubjzZKtkdvAa7KwQkNOXNXDJO0iqVL5KehWzMVK6OeL4ELgpDe7vqbMXJsxg
 YEsX7N2u92CWYqAJwGRdmUAW/vr+EqxUQgKoPG577lUmIp9UMB1CVOytrmn9YCzXZPsGI7wX+rm
 SWt+qaqhsHABa0jb6Ucu+E++R6ktWGNwQS/KKJnUZEE1yZXFPC3ZURizqokLiZ+vQaA6MCtPmpR
 qMAbiFqOG98xdKRIkcg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f3bf53 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=2JhxFxGQ8x84v9OSYXAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: 0RoD0pb4a8KTAtH2gJTH6H6lCGjbvlEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300210
X-Rspamd-Queue-Id: 79AEF4A7EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21317-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[misanjum@linux.ibm.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[11]

Hi,

Following up on my bug report, I have completed a git bisect and have 
critical new findings to report.
Ref: 
https://lore.kernel.org/linux-next/dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com/T/#u

Current Status: Bug Has Propagated from linux-next to Mainline.
First Bad commit identified: da6b5aae84beb0917ecb0c9fbc71169d145397ff

The use-after-free bug in cache_check_rcu() that I originally reported 
in linux-next (6.19.0-next-20260216/17) has now propagated into mainline 
and is confirmed present in:
- mainline (Tested on Latest kernel as of 2026-04-30 - commit 
08d0d3466664)
- linux-next (Tested on Latest kernel as of 2026-04-30)

This bug is causing failures on ppc64le systems:
1. Kernel panics: 100% reproducible crashes when sosreport runs
2. CI/Testing failures: All automated Avocado-vt KVM testing on ppc64le 
is failing
3. Use-after-free corruption: Memory corruption with corrupted pointers 
containing
    ASCII strings ("libz.so.", "export_cap") or poison patterns 
(0xcccccccccccccccc)

Test Environment:
Architecture: ppc64le (IBM Power11 and IBM Power10)
Hypervisor: phyp (PowerVM)
Distribution: Fedora 42 (Server Edition Prerelease)
Reproducible: 100%

Reproduction Steps:
On ppc64le system with latest kernel:
1. Run: modprobe nfsd
2. Run: sosreport
System crashes (typically within 30-60 seconds)

First bad commit:
commit da6b5aae84beb0917ecb0c9fbc71169d145397ff
Merge: b69e478512080 344bf523d441d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Apr 20 10:15:32 2026 -0700
     Merge tag 'platform-drivers-x86-v7.1-1' of
     
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
     Pull x86 platform driver updates from Ilpo Järvinen:
      "asus-wmi:
        - Retain battery charge threshold during boot which avoids
          unsolicited change to 100%. Return -ENODATA when the limit
          is not yet known
        - Improve screenpad power/brightness handling consistency
        - Fix screenpad brightness range
       barco-p50-gpio:
        - Normalize gpio_get return values
       bitland-mifs-wmi:
        - Add driver for Bitland laptops (supports platform profile,
          hwmon, kbd backlight, gpu mode, hotkeys, and fan boost)
       dell_rbu:
        - Fix using uninitialized value in sysfs write function
       dell-wmi-sysman:
        - Respect destination length when constructing enum strings
       hp-wmi:
        - Propagate fan setting apply failures and log an error
        - Fix sysfs write vs work handler cancel_delayed_work_sync() 
deadlock
        - Correct keepalive schedule_delayed_work() to mod_delayed_work()
        - Fix u8 underflows in GPU delta calculation
        - Use mutex to protect fan pwm/mode
        - Ignore kbd backlight and FnLock key events that are handled by 
FW
        - Fix fan table parsing (use correct field)
        - Add support for Omen 14-fb0xxx, 16-n0xxx, 16-wf1xxx, and
          Omen MAX 16-ak0xxxx
       input: trackpoint & thinkpad_acpi:
        - Enable doubletap by default and add sysfs enable/disable
       int3472:
        - Add support for GPIO type 0x02 (IR flood LED)
       intel-speed-select: (updated to v1.26)
        - Avoid using current base frequency as maximum
        - Fix CPU extended family ID decoding
        - Fix exit code
        - Improve error reporting
       intel/vsec:
        - Refactor to support ACPI-enumerated PMT endpoints.
       pcengines-apuv2:
        - Attach software node to the gpiochip
       uniwill:
        - Refactor hwmon to smaller parts to accomodate HW diversity
        - Support USB-C power/performance priority switch through sysfs
        - Add another XMG Fusion 15 (L19) DMI vendor
        - Enable fine-grained features to device lineup mapping
       wmi:
        - Perform output size check within WMI core to allow simpler WMI
          drivers
       misc:
        - acpi_driver -> platform driver conversions (a large number of
          changes from Rafael J. Wysocki)
        - cleanups / refactoring / improvements"
     * tag 'platform-drivers-x86-v7.1-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86: 
(106 commits)
       platform/x86: hp-wmi: Add support for Omen 16-wf1xxx (8C77)
       platform/x86: hp-wmi: Add support for Omen 16-n0xxx (8A44)
       platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8D87)
       platform/x86: hp-wmi: fix fan table parsing
       platform/x86: hp-wmi: add Omen 14-fb0xxx (board 8C58) support
       platform/wmi: Replace .no_notify_data with .min_event_size
       platform/wmi: Extend wmidev_query_block() to reject undersized 
data
       platform/wmi: Extend wmidev_invoke_method() to reject undersized 
data
       platform/wmi: Prepare to reject undersized unmarshalling results
       platform/wmi: Convert drivers to use wmidev_invoke_procedure()
       platform/wmi: Add wmidev_invoke_procedure()
       platform/x86: int3472: Add support for GPIO type 0x02 (IR flood 
LED)
       platform/x86: int3472: Parameterize LED con_id in registration
       platform/x86: int3472: Rename pled to led in LED registration code
       platform/x86: int3472: Use local variable for LED struct access
       platform/x86: thinkpad_acpi: remove obsolete TODO comment
       platform/x86: dell-wmi-sysman: bound enumeration string 
aggregation
       platform/x86: hp-wmi: Ignore backlight and FnLock events
       platform/x86: uniwill-laptop: Fix signedness bug
       platform/x86: dell_rbu: avoid uninit value usage in 
packet_size_write()
       ...
  .../sysfs-driver-uniwill-laptop       |  27 +
  .../laptops/thinkpad-acpi.rst         |  21 +
  .../laptops/uniwill-laptop.rst        |  12 +
  .../wmi/devices/bitland-mifs-wmi.rst  | 207 +++
  .../wmi/driver-development-guide.rst  |  11 +-
  drivers/gpu/drm/xe/xe_debugfs.c       |   2 +-
  drivers/gpu/drm/xe/xe_hwmon.c         |   2 +-
  drivers/gpu/drm/xe/xe_vsec.c          |   7 +-
  drivers/gpu/drm/xe/xe_vsec.h          |   4 +-
  drivers/input/mouse/trackpoint.c      |  46 +
  drivers/input/mouse/trackpoint.h      |   5 +
  .../platform/mellanox/nvsw-sn2201.c   |   1 -
  .../surface/surface_hotplug.c         |   2 +-
  .../surface/surfacepro3_button.c      |  71 +-
  drivers/platform/wmi/core.c           |  89 +-
  drivers/platform/wmi/internal.h       |   3 +-
  drivers/platform/wmi/marshalling.c    |   6 +-
  .../wmi/tests/marshalling_kunit.c     |  24 +-
  drivers/platform/x86/Kconfig          |  18 +
  drivers/platform/x86/Makefile         |   1 +
  drivers/platform/x86/acer-wireless.c  |  48 +-
  drivers/platform/x86/asus-laptop.c    |  44 +-
  drivers/platform/x86/asus-wireless.c  |  55 +-
  drivers/platform/x86/asus-wmi.c       |  77 +-
  drivers/platform/x86/barco-p50-gpio.c |  23 +-
  .../platform/x86/bitland-mifs-wmi.c   | 837 +++++++++++++
  drivers/platform/x86/dell/dell-rbtn.c | 142 ++-
  .../platform/x86/dell/dell-wmi-base.c |   1 +
  .../dell-wmi-sysman/dell-wmi-sysman.h |   4 +-
  .../dell-wmi-sysman/enum-attributes.c |  34 +-
  .../x86/dell/dell-wmi-sysman/sysman.c |  68 +-
  drivers/platform/x86/dell/dell_rbu.c  |   6 +-
  drivers/platform/x86/eeepc-laptop.c   |  45 +-
  drivers/platform/x86/fujitsu-laptop.c | 489 ++++----
  drivers/platform/x86/fujitsu-tablet.c |  30 +-
  drivers/platform/x86/hp/hp-wmi.c      | 125 +-
  .../x86/intel/int3472/discrete.c      |  13 +-
  .../platform/x86/intel/int3472/led.c  |  55 +-
  drivers/platform/x86/intel/pmc/core.c |   4 +-
  .../x86/intel/pmc/ssram_telemetry.c   |   2 +-
  .../platform/x86/intel/pmt/class.c    |   8 +-
  .../platform/x86/intel/pmt/class.h    |   5 +-
  .../x86/intel/pmt/discovery.c         |   4 +-
  .../x86/intel/pmt/telemetry.c         |  13 +-
  .../x86/intel/pmt/telemetry.h         |  12 +-
  drivers/platform/x86/intel/rst.c      |  23 +-
  drivers/platform/x86/intel/sdsi.c     |   5 +-
  .../platform/x86/intel/smartconnect.c |  23 +-
  drivers/platform/x86/intel/vsec.c     | 121 +-
  .../platform/x86/intel/vsec_tpmi.c    |  12 +-
  .../x86/intel/wmi/sbl-fw-update.c     |   7 +-
  .../x86/intel/wmi/thunderbolt.c       |   2 +-
  .../x86/lenovo/ideapad-laptop.c       |   1 +
  .../x86/lenovo/thinkpad_acpi.c        | 193 ++-
  .../platform/x86/lenovo/wmi-camera.c  |   1 +
  .../platform/x86/lenovo/wmi-events.c  |   1 +
  drivers/platform/x86/lenovo/ymc.c     |   1 +
  .../platform/x86/lenovo/yogabook.c    |   2 +-
  drivers/platform/x86/lg-laptop.c      |  51 +-
  drivers/platform/x86/mxm-wmi.c        |  12 -
  .../platform/x86/panasonic-laptop.c   |  79 +-
  .../platform/x86/pcengines-apuv2.c    |   3 +-
  drivers/platform/x86/redmi-wmi.c      |   1 +
  drivers/platform/x86/sony-laptop.c    | 122 +-
  drivers/platform/x86/system76_acpi.c  |  63 +-
  drivers/platform/x86/topstar-laptop.c |  43 +-
  drivers/platform/x86/toshiba_acpi.c   | 182 +--
  .../platform/x86/toshiba_bluetooth.c  |  74 +-
  drivers/platform/x86/toshiba_haps.c   |  57 +-
  .../x86/uniwill/uniwill-acpi.c        | 440 +++++--
  .../x86/uniwill/uniwill-wmi.c         |   1 +
  .../platform/x86/wireless-hotkey.c    |  49 +-
  drivers/platform/x86/wmi-bmof.c       |   2 +-
  drivers/platform/x86/xiaomi-wmi.c     |   1 +
  include/linux/intel_vsec.h            |  39 +-
  .../linux/platform_data/x86/int3472.h |  12 +-
  include/linux/wmi.h                   |  15 +-
  .../intel-speed-select/isst-config.c  |  41 +-
  78 files changed, 3073 insertions(+), 1309 deletions(-)
  create mode 100644 Documentation/wmi/devices/bitland-mifs-wmi.rst
  create mode 100644 drivers/platform/x86/bitland-mifs-wmi.c

Complete Bisect Log:
git bisect start
# good: [eb0d6d97c27c29cd7392c8fd74f46edf7dff7ec2] Merge tag 'bpf-fixes'
git bisect good eb0d6d97c27c29cd7392c8fd74f46edf7dff7ec2
# bad: [d46dd0d88341e45f8e0226fdef5462f5270898fc] Merge tag 
'f2fs-for-7.1-rc1'
git bisect bad d46dd0d88341e45f8e0226fdef5462f5270898fc
# good: [99ef60d119f3b2621067dd5fc1ea4a37360709e4] Merge tag 
'usb-7.1-rc1'
git bisect good 99ef60d119f3b2621067dd5fc1ea4a37360709e4
# good: [b69e478512080f9bb03ed3e812b759bb73e2837b] Merge tag 
'backlight-next-7.1'
git bisect good b69e478512080f9bb03ed3e812b759bb73e2837b
# bad: [a85d6ff99411eb21536a750ad02205e8a97894c6] Merge tag 'scsi-misc'
git bisect bad a85d6ff99411eb21536a750ad02205e8a97894c6
# bad: [ce9e93383ad71da468dafb9944a539808bf91c06] Merge tag 
'sh-for-v7.1-tag1'
git bisect bad ce9e93383ad71da468dafb9944a539808bf91c06
# good: [378500dc1313e2c06a2f675bb00ab5d7880433ba] platform/x86: 
asus-laptop: Register ACPI notify handler directly
git bisect good 378500dc1313e2c06a2f675bb00ab5d7880433ba
# good: [9d317a54e46d3b6420567dc5b63e9d7ff5c064a3] platform/x86: hp-wmi: 
fix fan table parsing
git bisect good 9d317a54e46d3b6420567dc5b63e9d7ff5c064a3
# bad: [b66cb4f156fe47f52065e70eb1b2f12ccd0c2884] Merge tag 
'printk-for-7.1'
git bisect bad b66cb4f156fe47f52065e70eb1b2f12ccd0c2884
# good: [add9d911be9b141706ccf41d17b4043ed1bc12a1] Merge branch 
'rework/prb-fixes' into for-linus
git bisect good add9d911be9b141706ccf41d17b4043ed1bc12a1
# bad: [da6b5aae84beb0917ecb0c9fbc71169d145397ff] Merge tag 
'platform-drivers-x86-v7.1-1'
git bisect bad da6b5aae84beb0917ecb0c9fbc71169d145397ff
# good: [899225257e78585e2e10b0f7ba472b3c212a8d16] platform/x86: hp-wmi: 
Add support for Omen 16-n0xxx (8A44)
git bisect good 899225257e78585e2e10b0f7ba472b3c212a8d16
# good: [344bf523d441d44c75c429ea6cdcfa8f12efde4d] platform/x86: hp-wmi: 
Add support for Omen 16-wf1xxx (8C77)
git bisect good 344bf523d441d44c75c429ea6cdcfa8f12efde4d
# first bad commit: [da6b5aae84beb0917ecb0c9fbc71169d145397ff] Merge tag 
'platform-drivers-x86-v7.1-1'

Crash Log Call Trace:
[ 1721.304746] BUG: Unable to handle kernel data access on read at 
0x50000004e
[ 1721.304751] Faulting instruction address: 0xc008000015b11d9c
[ 1721.304756] Oops: Kernel access of bad area, sig: 11 [#1]
[ 1721.304760] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA pSeries
[ 1721.304767] Modules linked in: nft_masq nft_ct nft_reject_ipv4 
nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc 
binfmt_misc rpcrdma rdma_cm iw_cm ib_cm kvm_hv ib_core kvm bonding 
rfkill pseries_rng vmx_crypto nfsd auth_rpcgss nfs_acl drm lockd grace 
loop drm_panel_orientation_quirks nfnetlink vsock_loopback 
vmw_vsock_virtio_transport_common vsock zram xfs dm_service_time sd_mod 
ibmvscsi ibmveth scsi_transport_srp ipr btrfs xor libblake2b raid6_pq 
zstd_compress sunrpc dm_mirror dm_region_hash dm_log be2iscsi bnx2i cnic 
uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp 
libiscsi_tcp libiscsi scsi_transport_iscsi dm_multipath fuse dm_mod
[ 1721.304844] CPU: 32 UID: 0 PID: 7187 Comm: sosreport Not tainted 
7.0.0-12182-gda6b5aae84be #17 PREEMPTLAZY
[ 1721.304849] Hardware name: IBM,9080-HEX POWER10 (architected) 
0x800200 0xf000006 of:IBM,FW1060.70 (NH1060_166) hv:phyp pSeries
[ 1721.304854] NIP:  c008000015b11d9c LR: c008000015b121a0 CTR: 
c008000015b12138
[ 1721.304858] REGS: c0000010bfef7750 TRAP: 0300   Not tainted  
(7.0.0-12182-gda6b5aae84be)
[ 1721.304862] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
28044402  XER: 00000000
[ 1721.304871] CFAR: c008000015b1219c DAR: 000000050000004e DSISR: 
40000000 IRQMASK: 0
[ 1721.304871] GPR00: c008000015b121a0 c0000010bfef79f0 c008000014737a00 
c00000002091f400
[ 1721.304871] GPR04: 0000000500000026 0000000000000000 0000000000000000 
c0000000a66ce800
[ 1721.304871] GPR08: c00000002091f400 0000000000000000 0000000000400cc0 
0000000000000000
[ 1721.304871] GPR12: c008000015b12138 c000001bfffff300 0000000000000000 
0000000000000000
[ 1721.304871] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1721.304871] GPR20: 0000000000000000 0000000000000000 c00000101bb29f08 
c00000101bb29ef8
[ 1721.304871] GPR24: 000000007fff0000 0000000000000000 fffffffffffff000 
0000000000000000
[ 1721.304871] GPR28: c00000002091f400 0000000000000000 c00000101bb29ed0 
0000000500000026
[ 1721.304911] NIP [c008000015b11d9c] cache_check_rcu+0x44/0x2c0 
[sunrpc]
[ 1721.304950] LR [c008000015b121a0] c_show+0x68/0x1c0 [sunrpc]
[ 1721.304984] Call Trace:
[ 1721.304986] [c0000010bfef79f0] [c0000010bfef7a30] 0xc0000010bfef7a30 
(unreliable)
[ 1721.304992] [c0000010bfef7aa0] [c008000015b121a0] c_show+0x68/0x1c0 
[sunrpc]
[ 1721.305027] [c0000010bfef7b50] [c0000000007b9b28] 
seq_read_iter+0x1a8/0x680
[ 1721.305034] [c0000010bfef7c20] [c0000000007ba104] 
seq_read+0x104/0x150
[ 1721.305038] [c0000010bfef7cc0] [c000000000863920] 
proc_reg_read+0xf0/0x160
[ 1721.305043] [c0000010bfef7cf0] [c000000000768b00] vfs_read+0xe0/0x3d0
[ 1721.305049] [c0000010bfef7db0] [c000000000769a08] 
ksys_read+0x78/0x140
[ 1721.305054] [c0000010bfef7e00] [c000000000034908] 
system_call_exception+0x128/0x360
[ 1721.305061] [c0000010bfef7e50] [c00000000000d6a0] 
system_call_common+0x160/0x2e4
[ 1721.305066] ---- interrupt: c00 at 0x7fffba6b9fc8
[ 1721.305069] NIP:  00007fffba6b9fc8 LR: 00007fffba6a8438 CTR: 
0000000000000000
[ 1721.305072] REGS: c0000010bfef7e80 TRAP: 0c00   Not tainted  
(7.0.0-12182-gda6b5aae84be)
[ 1721.305075] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28044404  XER: 00000000
[ 1721.305085] IRQMASK: 0
[ 1721.305085] GPR00: 0000000000000003 00007fffa77ed9b0 00007fffba847c00 
0000000000000007
[ 1721.305085] GPR04: 00007fff940230f0 0000000000010000 0000000000000000 
0000000000000000
[ 1721.305085] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1721.305085] GPR12: 0000000000000000 00007fffa77f6880 0000000000000000 
0000000000000000
[ 1721.305085] GPR16: 0000000000000000 0000000000000000 00007fffb87f0828 
00007fffa77edf68
[ 1721.305085] GPR20: 00007fffb87f0830 00007fffbaded480 00007fffb87f0838 
00007fffbae0d480
[ 1721.305085] GPR24: 00007fffbaf8e0f0 00007fff940230f0 0000000000000007 
00007fffac001290
[ 1721.305085] GPR28: 0000000000000000 00007fffa77ef8b0 00007fffa4590b40 
0000000000010000
[ 1721.305120] NIP [00007fffba6b9fc8] 0x7fffba6b9fc8
[ 1721.305122] LR [00007fffba6a8438] 0x7fffba6a8438
[ 1721.305125] ---- interrupt: c00
[ 1721.305127] Code: fba1ffe8 fbe1fff8 fb61ffd8 fbc1fff0 7c9f2378 
7c7c1b78 7cbd2b78 f8010010 f821ff51 e92d0c78 f9210078 39200000 
<e9240028> 71290001 418201cc fb410080
[ 1721.305141] ---[ end trace 0000000000000000 ]---
[ 1721.307464] pstore: backend (nvram) writing error (-1)
[ 1721.307468]
[ 1722.307472] Kernel panic - not syncing: Fatal exception
[ 1722.321570] Rebooting in 10 seconds..

Thanks,
Misbah Anjum N <misanjum@linux.ibm.com>


On 2026-02-19 18:57, Misbah Anjum N wrote:
> Hi,
> 
> I'm reporting a critical use-after-free bug in linux-next NFS server
> code that causes kernel crashes when sosreport reads /proc/fs/nfsd/*
> files. This appears to be a recent regression affecting ppc64le
> systems.
> The bug is 100% reproducible and shows corrupted pointers containing
> ASCII strings (library names, export cache names) instead of valid
> kernel addresses, indicating freed memory has been reallocated.
> 
> Thanks,
> Misbah Anjum N
> 
> Bug Description:
> The kernel crashes with use-after-free in cache_check_rcu() [sunrpc]
> when sosreport reads NFS export information from /proc. The bug is
> highly reproducible and consistently shows corrupted pointers
> containing ASCII strings (library names, export cache names,
> filesystem paths) instead of valid kernel addresses.
> This is a critical regression in linux-next that needs to be fixed
> before reaching mainline.
> 
> System Information:
> Kernel: 6.19.0-next-20260216 and 6.19.0-next-20260217
> Architecture: ppc64le (IBM Power11, 9080-HEX)
> Hardware: IBM,9080-HEX Power11 (architected) 0x820200 0xf000007
> Firmware: IBM,FW1110.11 (NH1110_102)
> Hypervisor: phyp (PowerVM)
> Distribution: Fedora 42 (Server Edition Prerelease)
> Reproducible: 100%
> 
> Reproduction Steps:
> On ppc64le system with kernel 6.19.0-next-20260216/17:
> 1. Run: modprobe nfsd
> 2. Run: sosreport
> System crashes (typically within 30-60 seconds)
> 
> Important notes:
> 1. Direct cat /proc/fs/nfsd/exports does NOT trigger the crash
> 2. The crash is triggered by sosreport's specific access pattern to
> /proc/fs/nfsd/* files
> 3. No NFS exports or active NFS server configuration needed
> 4. Reproducible 100% of the time with sosreport
> 
> Kernel Configuration:
> Relevant NFS configuration options:
> CONFIG_NFSD=m
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_PNFS=y
> CONFIG_NFSD_SCSILAYOUT=y
> CONFIG_NFSD_V4_2_INTER_SSC=y
> CONFIG_NFSD_V4_SECURITY_LABEL=y
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=m
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=m
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_NFS_V4_SECURITY_LABEL=y
> CONFIG_NFS_FSCACHE=y
> CONFIG_NFS_DEBUG=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> CONFIG_NFS_ACL_SUPPORT=m
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_DEBUG=y
> 
> Detailed Crash Traces:
> Crash #1 - cache_check_rcu() with "export_cap" pointer 
> (6.19.0-next-20260216)
> [ 3162.071511] BUG: Unable to handle kernel data access at 
> 0x657079745f70618b
> [ 3162.071529] Faulting instruction address: 0xc0080000083322bc
> [ 3162.071534] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 3162.071537] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA 
> pSeries
> [ 3162.071542] Modules linked in: binfmt_misc vhost_net vhost
> vhost_iotlb tap tun nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4
> nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc rpcrdma rdma_cm
> iw_cm kvm_hv ib_cm ib_core kvm bonding rfkill nfsd auth_rpcgss nfs_acl
> lockd grace pseries_rng vmx_crypto drm loop
> drm_panel_orientation_quirks nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common vsock zram xfs dm_service_time
> sd_mod ibmvscsi ibmveth scsi_transport_srp tg3 ipr btrfs xor
> libblake2b raid6_pq zstd_compress sunrpc dm_mirror dm_region_hash
> dm_log be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb
> qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi dm_multipath fuse dm_mod
> [ 3162.071618] CPU: 51 UID: 0 PID: 52936 Comm: sosreport Kdump: loaded
> Not tainted 6.19.0-next-20260216 #1 PREEMPTLAZY
> [ 3162.071623] Hardware name: IBM,9080-HEX Power11 (architected)
> 0x820200 0xf000007 of:IBM,FW1110.11 (NH1110_102) hv:phyp pSeries
> [ 3162.071627] NIP:  c0080000083322bc LR: c0080000115f6b48 CTR: 
> c008000008332278
> [ 3162.071631] REGS: c0000000b353f7c0 TRAP: 0380   Not tainted
> (6.19.0-next-20260216)
> [ 3162.071635] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
> 48044402  XER: 00000000
> [ 3162.071643] CFAR: c00800001164e15c IRQMASK: 0
> [ 3162.071643] GPR00: c0080000115f6b48 c0000000b353fa60
> c008000008397600 c00000012a758700
> [ 3162.071643] GPR04: 657079745f706163 0000000000000000
> 0000000000000000 c000000144b4d000
> [ 3162.071643] GPR08: c00000012a758700 0000000000000000
> 0000000000400cc0 c00800001164e148
> [ 3162.071643] GPR12: c008000008332278 c0000027fde49f00
> 0000000000000000 0000000000000000
> [ 3162.071643] GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [ 3162.071643] GPR20: 0000000000000000 0000000000000000
> c000000145433788 c000000145433778
> [ 3162.071643] GPR24: 000000007fff0000 0000000000000000
> fffffffffffff000 0000000000000000
> [ 3162.071643] GPR28: c00000012a758700 0000000000000000
> c00000012a758700 657079745f706163
> [ 3162.071682] NIP [c0080000083322bc] cache_check_rcu+0x44/0x2c0 
> [sunrpc]
> [ 3162.071716] LR [c0080000115f6b48] e_show+0x40/0x260 [nfsd]
> [ 3162.071747] Call Trace:
> [ 3162.071749] [c0000000b353fa60] [c0000000b353fb50]
> 0xc0000000b353fb50 (unreliable)
> [ 3162.071754] [c0000000b353fb10] [c0080000115f6b48] e_show+0x40/0x260 
> [nfsd]
> [ 3162.071780] [c0000000b353fb50] [c0000000007a7468] 
> seq_read_iter+0x1a8/0x680
> [ 3162.071787] [c0000000b353fc20] [c0000000007a7a44] 
> seq_read+0x104/0x150
> [ 3162.071791] [c0000000b353fcc0] [c00000000084ecb0] 
> proc_reg_read+0xf0/0x160
> [ 3162.071796] [c0000000b353fcf0] [c000000000756b00] 
> vfs_read+0xe0/0x3d0
> [ 3162.071800] [c0000000b353fdb0] [c000000000757a08] 
> ksys_read+0x78/0x140
> [ 3162.071804] [c0000000b353fe00] [c0000000000348c8]
> system_call_exception+0x128/0x350
> [ 3162.071809] [c0000000b353fe50] [c00000000000d6a0]
> system_call_common+0x160/0x2e4
> [ 3162.071815] ---- interrupt: c00 at 0x7fff7ecb9fc8
> [ 3162.071818] NIP:  00007fff7ecb9fc8 LR: 00007fff7eca8438 CTR: 
> 0000000000000000
> [ 3162.071821] REGS: c0000000b353fe80 TRAP: 0c00   Not tainted
> (6.19.0-next-20260216)
> [ 3162.071824] MSR:  800000000280f033
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28044404  XER: 00000000
> [ 3162.071834] IRQMASK: 0
> [ 3162.071834] GPR00: 0000000000000003 00007fff6afdd9d0
> 00007fff7ee47c00 0000000000000005
> [ 3162.071834] GPR04: 00007fff5c0223c0 0000000000010000
> 0000000000000000 0000000000000000
> [ 3162.071834] GPR08: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [ 3162.071834] GPR12: 0000000000000000 00007fff6afe68a0
> 0000000000000000 0000000000000000
> [ 3162.071834] GPR16: 0000000000000000 0000000000000000
> 00007fff7d800828 00007fff6afddf88
> [ 3162.071834] GPR20: 00007fff7d800830 00007fff7f3ed480
> 00007fff7d800838 00007fff7f40d480
> [ 3162.071834] GPR24: 00007fff7f58e0f0 00007fff5c0223c0
> 0000000000000005 00007fff6c001290
> [ 3162.071834] GPR28: 0000000000000000 00007fff6afdf8d0
> 00007fff79db3140 0000000000010000
> [ 3162.071870] NIP [00007fff7ecb9fc8] 0x7fff7ecb9fc8
> [ 3162.071872] LR [00007fff7eca8438] 0x7fff7eca8438
> [ 3162.071875] ---- interrupt: c00
> [ 3162.071877] Code: fba1ffe8 fbe1fff8 fb61ffd8 fbc1fff0 7c9f2378
> 7c7c1b78 7cbd2b78 f8010010 f821ff51 e92d0c78 f9210078 39200000
> <e9240028> 71290001 418201cc fb410080
> [ 3162.071890] ---[ end trace 0000000000000000 ]---
> 
> Crash #2 - d_path() NULL pointer dereference (6.19.0-next-20260217)
> [ 5489.374563] Kernel attempted to read user page (60) - exploit
> attempt? (uid: 0)
> [ 5489.374582] BUG: Kernel NULL pointer dereference on read at 
> 0x00000060
> [ 5489.374586] Faulting instruction address: 0xc0000000007cb354
> [ 5489.374590] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 5489.374593] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA 
> pSeries
> [ 5489.374598] Modules linked in: binfmt_misc vhost_net vhost
> vhost_iotlb tap tun nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4
> nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc rpcrdma rdma_cm
> iw_cm kvm_hv ib_cm kvm ib_core bonding rfkill nfsd auth_rpcgss nfs_acl
> lockd grace pseries_rng vmx_crypto drm loop
> drm_panel_orientation_quirks nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common vsock zram xfs dm_service_time
> sd_mod ibmvscsi tg3 ibmveth scsi_transport_srp ipr btrfs xor
> libblake2b raid6_pq zstd_compress sunrpc dm_mirror dm_region_hash
> dm_log be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb
> qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi dm_multipath fuse dm_mod
> [ 5489.374671] CPU: 2 UID: 0 PID: 45718 Comm: sosreport Kdump: loaded
> Not tainted 6.19.0-next-20260217 #1 PREEMPTLAZY
> [ 5489.374676] Hardware name: IBM,9080-HEX Power11 (architected)
> 0x820200 0xf000007 of:IBM,FW1110.11 (NH1110_102) hv:phyp pSeries
> [ 5489.374680] NIP:  c0000000007cb354 LR: c0000000007a7ed0 CTR: 
> c0000000007a7e60
> [ 5489.374683] REGS: c00000026f2676b0 TRAP: 0300   Not tainted
> (6.19.0-next-20260217)
> [ 5489.374688] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
> 88044408  XER: 00000000
> [ 5489.374696] CFAR: c0000000007a7ecc DAR: 0000000000000060 DSISR:
> 40000000 IRQMASK: 0
> [ 5489.374696] GPR00: c0000000007a7ed0 c00000026f267950
> c000000001868100 0000000000000000
> [ 5489.374696] GPR04: c0000012e1350002 000000000000fffe
> c00800000ee360f0 c0000012e1350002
> [ 5489.374696] GPR08: 000000000000fffe c000000146400840
> c0000012e1360000 0000000000000000
> [ 5489.374696] GPR12: c0000000007a7e60 c0000027ffffdf00
> 0000000000000000 0000000000000000
> [ 5489.374696] GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [ 5489.374696] GPR20: 0000000000000000 0000000000000000
> c0000000bbca06c8 c0000000bbca06b8
> [ 5489.374696] GPR24: 000000007fff0000 0000000000000000
> fffffffffffff000 0000000000000000
> [ 5489.374696] GPR28: c00000026f267c50 c000000140db5800
> c000000146400800 c0000012e1350002
> [ 5489.374736] NIP [c0000000007cb354] d_path+0x44/0x210
> [ 5489.374742] LR [c0000000007a7ed0] seq_path+0x70/0x160
> [ 5489.374747] Call Trace:
> [ 5489.374749] [c00000026f267950] [0000000000000006] 0x6 (unreliable)
> [ 5489.374755] [c00000026f2679b0] [c0000000007a7ed0] 
> seq_path+0x70/0x160
> [ 5489.374759] [c00000026f2679f0] [c00800001144673c]
> svc_export_show+0x1d4/0x5a0 [nfsd]
> [ 5489.374789] [c00000026f267aa0] [c008000004a126fc] c_show+0xa4/0x1c0 
> [sunrpc]
> [ 5489.374819] [c00000026f267b50] [c0000000007a7468] 
> seq_read_iter+0x1a8/0x680
> [ 5489.374824] [c00000026f267c20] [c0000000007a7a44] 
> seq_read+0x104/0x150
> [ 5489.374829] [c00000026f267cc0] [c00000000084ecb0] 
> proc_reg_read+0xf0/0x160
> [ 5489.374833] [c00000026f267cf0] [c000000000756af0] 
> vfs_read+0xe0/0x3d0
> [ 5489.374837] [c00000026f267db0] [c0000000007579f8] 
> ksys_read+0x78/0x140
> [ 5489.374841] [c00000026f267e00] [c0000000000348c8]
> system_call_exception+0x128/0x350
> [ 5489.374846] [c00000026f267e50] [c00000000000d6a0]
> system_call_common+0x160/0x2e4
> [ 5489.374852] ---- interrupt: c00 at 0x7fff866b9fc8
> [ 5489.374855] NIP:  00007fff866b9fc8 LR: 00007fff866a8438 CTR: 
> 0000000000000000
> [ 5489.374858] REGS: c00000026f267e80 TRAP: 0c00   Not tainted
> (6.19.0-next-20260217)
> [ 5489.374861] MSR:  800000000280f033
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28044404  XER: 00000000
> [ 5489.374871] IRQMASK: 0
> [ 5489.374871] GPR00: 0000000000000003 00007fff71fbd9d0
> 00007fff86847c00 0000000000000008
> [ 5489.374871] GPR04: 00007fff600228e0 0000000000010000
> 0000000000000000 0000000000000000
> [ 5489.374871] GPR08: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [ 5489.374871] GPR12: 0000000000000000 00007fff71fc68a0
> 0000000000000000 0000000000000000
> [ 5489.374871] GPR16: 0000000000000000 0000000000000000
> 00007fff847f0828 00007fff71fbdf88
> [ 5489.374871] GPR20: 00007fff847f0830 00007fff86ded480
> 00007fff847f0838 00007fff86e0d480
> [ 5489.374871] GPR24: 00007fff86f8e0f0 00007fff600228e0
> 0000000000000008 00007fff6c0016a0
> [ 5489.374871] GPR28: 0000000000000000 00007fff71fbf8d0
> 00007fff80548c40 0000000000010000
> [ 5489.374906] NIP [00007fff866b9fc8] 0x7fff866b9fc8
> [ 5489.374909] LR [00007fff866a8438] 0x7fff866a8438
> [ 5489.374912] ---- interrupt: c00
> [ 5489.374914] Code: f8010010 f821ffa1 f8410018 e92d0c78 f9210058
> 39200000 91410044 7c691b78 7d442a14 f9410038 e8630008 90a10040
> <e9430060> 2c2a0000 41820064 e98a0048
> [ 5489.374927] ---[ end trace 0000000000000000 ]---
> 
> Crash #3 - cache_check_rcu() with "libz.so." pointer 
> (6.19.0-next-20260217)
> [   63.748591] BUG: Unable to handle kernel data access at 
> 0x2e6f732e7a626994
> [   63.748601] Faulting instruction address: 0xc008000009de22bc
> [   63.748606] Oops: Kernel access of bad area, sig: 11 [#1]
> [   63.748609] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA 
> pSeries
> [   63.748614] Modules linked in: nft_masq nft_ct nft_reject_ipv4
> nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb nft_chain_nat
> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp
> llc binfmt_misc rpcrdma rdma_cm iw_cm kvm_hv ib_cm kvm ib_core bonding
> rfkill nfsd auth_rpcgss nfs_acl lockd grace pseries_rng vmx_crypto drm
> loop drm_panel_orientation_quirks nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common vsock zram xfs dm_service_time
> sd_mod tg3 ibmvscsi ibmveth scsi_transport_srp ipr btrfs xor
> libblake2b raid6_pq zstd_compress sunrpc dm_mirror dm_region_hash
> dm_log be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb
> qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi dm_multipath fuse dm_mod
> [   63.748680] CPU: 58 UID: 0 PID: 5675 Comm: sosreport Kdump: loaded
> Not tainted 6.19.0-next-20260217 #1 PREEMPTLAZY
> [   63.748686] Hardware name: IBM,9080-HEX Power11 (architected)
> 0x820200 0xf000007 of:IBM,FW1110.11 (NH1110_102) hv:phyp pSeries
> [   63.748690] NIP:  c008000009de22bc LR: c00800000f086b48 CTR: 
> c008000009de2278
> [   63.748693] REGS: c0000000a3a4f7c0 TRAP: 0380   Not tainted
> (6.19.0-next-20260217)
> [   63.748697] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
> 48044402  XER: 00000000
> [   63.748706] CFAR: c00800000f0de15c IRQMASK: 0
> [   63.748706] GPR00: c00800000f086b48 c0000000a3a4fa60
> c008000006f47600 c0000000b70f9b00
> [   63.748706] GPR04: 2e6f732e7a62696c 0000000000000000
> 0000000000000000 c000000152f70800
> [   63.748706] GPR08: c0000000b70f9b00 0000000000000000
> 0000000000400cc0 c00800000f0de148
> [   63.748706] GPR12: c008000009de2278 c0000027fde40700
> 0000000000000000 0000000000000000
> [   63.748706] GPR16: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [   63.748706] GPR20: 0000000000000000 0000000000000000
> c0000000e2e17b08 c0000000e2e17af8
> [   63.748706] GPR24: 000000007fff0000 0000000000000000
> fffffffffffff000 0000000000000000
> [   63.748706] GPR28: c0000000b70f9b00 0000000000000000
> c0000000b70f9b00 2e6f732e7a62696c
> [   63.748744] NIP [c008000009de22bc] cache_check_rcu+0x44/0x2c0 
> [sunrpc]
> [   63.748776] LR [c00800000f086b48] e_show+0x40/0x260 [nfsd]
> [   63.748805] Call Trace:
> [   63.748807] [c0000000a3a4fa60] [c0000000a3a4fb50]
> 0xc0000000a3a4fb50 (unreliable)
> [   63.748812] [c0000000a3a4fb10] [c00800000f086b48] e_show+0x40/0x260 
> [nfsd]
> [   63.748839] [c0000000a3a4fb50] [c0000000007a7468] 
> seq_read_iter+0x1a8/0x680
> [   63.748845] [c0000000a3a4fc20] [c0000000007a7a44] 
> seq_read+0x104/0x150
> [   63.748850] [c0000000a3a4fcc0] [c00000000084ecb0] 
> proc_reg_read+0xf0/0x160
> [   63.748855] [c0000000a3a4fcf0] [c000000000756af0] 
> vfs_read+0xe0/0x3d0
> [   63.748859] [c0000000a3a4fdb0] [c0000000007579f8] 
> ksys_read+0x78/0x140
> [   63.748862] [c0000000a3a4fe00] [c0000000000348c8]
> system_call_exception+0x128/0x350
> [   63.748868] [c0000000a3a4fe50] [c00000000000d6a0]
> system_call_common+0x160/0x2e4
> [   63.748873] ---- interrupt: c00 at 0x7fffa74b9fc8
> [   63.748876] NIP:  00007fffa74b9fc8 LR: 00007fffa74a8438 CTR: 
> 0000000000000000
> [   63.748879] REGS: c0000000a3a4fe80 TRAP: 0c00   Not tainted
> (6.19.0-next-20260217)
> [   63.748882] MSR:  800000000280f033
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28044404  XER: 00000000
> [   63.748892] IRQMASK: 0
> [   63.748892] GPR00: 0000000000000003 00007fff8b7ed9d0
> 00007fffa7647c00 0000000000000008
> [   63.748892] GPR04: 00007fff7c021af0 0000000000010000
> 0000000000000000 0000000000000000
> [   63.748892] GPR08: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [   63.748892] GPR12: 0000000000000000 00007fff8b7f68a0
> 0000000000000000 0000000000000000
> [   63.748892] GPR16: 0000000000000000 0000000000000000
> 00007fffa55f0828 00007fff8b7edf88
> [   63.748892] GPR20: 00007fffa55f0830 00007fffa7bed480
> 00007fffa55f0838 00007fffa7c0d480
> [   63.748892] GPR24: 00007fffa7d8e0f0 00007fff7c021af0
> 0000000000000008 00007fff94001290
> [   63.748892] GPR28: 0000000000000000 00007fff8b7ef8d0
> 00007fffa062be00 0000000000010000
> [   63.748927] NIP [00007fffa74b9fc8] 0x7fffa74b9fc8
> [   63.748930] LR [00007fffa74a8438] 0x7fffa74a8438
> [   63.748933] ---- interrupt: c00
> [   63.748935] Code: fba1ffe8 fbe1fff8 fb61ffd8 fbc1fff0 7c9f2378
> 7c7c1b78 7cbd2b78 f8010010 f821ff51 e92d0c78 f9210078 39200000
> <e9240028> 71290001 418201cc fb410080
> [   63.748948] ---[ end trace 0000000000000000 ]---
> 
> Next Steps:
> I have vmcore dumps from multiple crashes and am working on:
> 1. Crash utility analysis to examine the corrupted cache structures
> 2. Git bisect to identify the problematic commit

