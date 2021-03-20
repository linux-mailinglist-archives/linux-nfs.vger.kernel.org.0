Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35F34299B
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Mar 2021 02:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCTBZ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 21:25:56 -0400
Received: from mail-eopbgr1320095.outbound.protection.outlook.com ([40.107.132.95]:6077
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229564AbhCTBZf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 21:25:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqrEO/xriF6s/jJLIjD4Fow+a6nEbCKe4NEDP/oYSiV9zerqL+Gs13eWzh1uC9uUUVymTl6cKlfulqwEDEa4GtjRaeuXtUSLw/Qd8UQA3k+NzK1SKBSvXBBDYAsxUV+HgTC96fCibiuSlueou4Ck+Lhqg/IMIwJBkkskZphNTCW4bb8cYj8FXTQDgYmI1wLJRF0A8rjq7lO8V/uH0Ytf/Tch4fw499CsVNEgBVXbsn5rgE8o6ox/3gFl0EJR3CO9mircw7A5ctGu+sJAzwxsttui7XUKrOHHjhShGgHT7d5RkDTIRQTkCFFKu61FAegZ28QwpsMD7K5KBPqFOhe8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgGFoJ8vwJDNxPCSuig0CB6LnRHN6nisTdKlEiiDpYY=;
 b=oL2wjmXU4d0+PNMc3/9XsflH0NOIQQ5M+/pnfXIJKqaGts6fsGwpm852xEqCATTbccK8O9AaYgHpnq+vjhLgyU6c67Ry/at7xupln0WVO+ADSJVrcJjsb3CKFZQUM/is/0yFArGZX4tXx6Fa5qJg9gvOkZZCwANFzD6nl6/GNFhfXEgpcoYsRgcuaRcWrWcdp/IGDKdm48RDU+JKN4Iuc1eZdiIMqe4p8wTrZhNGC5UG9t1Bv0Yjj4Dfe2wpxEtLq5YHrM4pIiIVNXzYa4SwjMb2wN+QKioUKajqkHsLib/xwVxJCtYv9wsBfhjTeEVa+hfecXQB0gVHkwcfY7ZHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgGFoJ8vwJDNxPCSuig0CB6LnRHN6nisTdKlEiiDpYY=;
 b=V0E3uCxQdqsFnCpRS+PDI4LlwHI9eJgelob3IeVgP4oT6117ANv28ov3n/Gi5Xp3mbHfsGwEYoqYdWQcuHUF5KQ6reM0ZzHpGzxx9aXb2wZ1jIREmLO+2oznlT6fn9ZrKUNkolnf7brHDTgMTG8CSNaJlsGZcGnHmeIiLWIve9g=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0031.APCP153.PROD.OUTLOOK.COM (2603:1096:3:10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.5; Sat, 20 Mar 2021 01:25:26 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.001; Sat, 20 Mar 2021
 01:25:26 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP address
Thread-Topic: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP
 address
Thread-Index: AdcdJ6TyS5d0b7lmQfaamCRuNxFJBg==
Date:   Sat, 20 Mar 2021 01:25:25 +0000
Message-ID: <SG2P153MB0361F4B85684C232E63C04749E679@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e190d4ec-a7e6-47b1-4e56-08d8eb3f0a48
x-ms-traffictypediagnostic: SG2P15301MB0031:
x-microsoft-antispam-prvs: <SG2P15301MB0031A360DB2DA675D603D5EF9E679@SG2P15301MB0031.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RrwXfQyO1paAHy4ifMDuE0TqH40JcrWgM15AsM4lC5Y5Fn1RW3ppRgB6JLEN2AvX78OS6GFLit0YabyP5x+Ak4L/4/u9sLFg+LCNoQ5JQQxrbdMOSjh9g0HAwpMOSihAZ5ef/T8Vyw6MRG92B24J+RpSyHXqgdY1BqjkObEK/LUEqlC231NkynhlNTA3vX7QxjbrTC2gaaWCVxbXSiR78YCZ8QxIeK5x++8UV1yknPwrtNpFheoHZS8w+hPd0yIlTgyzWbdVKftsh1kEVpmhf3qjYTAdaDC0ieTjBIfrOp24WYri/XI36qE6beOoX0OECu046VLFO+hNM0DA5z6jvun2V3GOXb3Xt4sR5Ri2RTCc/vMEQPECnB+QfwOofgEPm0fvLcyaI5pKLSiJoGqfMpWe6m+ETL0adU3fCmDFW0aep/lqXsTNE0NBUrgM1S5M2dnyWsXnYGX5fy+RSoi4//nhcVK1xU05uw3NF4Y+Q2tv3DXlhCuibWxKx/ch6ovVS2N5Mshv2wYDGYvQOpLyV7GviiIF2ZKo9yXc9KO5eQwmyUjMgaAaBBRtSfszerwNxSW7QKmr18rOshb4dCxhpsEs/hLj8pfCrAnO6oRX5QqDI+6ks1MWa4S185iKl58JaQa8cOM7D+gja/rbQ3Gvm6NZo7Pzu+pSk3ZxLS+y638=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(10290500003)(26005)(8990500004)(82960400001)(82950400001)(2906002)(55016002)(86362001)(6506007)(478600001)(83380400001)(38100700001)(71200400001)(9686003)(186003)(66446008)(8936002)(66556008)(66946007)(5660300002)(66476007)(52536014)(33656002)(8676002)(7696005)(316002)(76116006)(64756008)(53546011)(110136005)(55236004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CXIcZdwwQWECImpV9GKjr6Gje/Zt8+CkErsOPnwo7HOEaB7LcMIf/PA83Iqk?=
 =?us-ascii?Q?eu21tiUX2TcRF5Y6lGEf1RAdYW2Cskor6zfiI2/LaXu/N7MqHGNhQ6wNPqR4?=
 =?us-ascii?Q?/n9pG/Abof6YlVMbtnRsNbNc6JV2oMnjkqN7kbahHbAzpC+tDUeuShEyqnCS?=
 =?us-ascii?Q?GhszEqRqZo0LhjsbN9aawLlQobS1fzYexYaqp42OsF2bDex28MCCXZNlPLMf?=
 =?us-ascii?Q?2XS2eakqt4pfywbwsKrbzh1bK82P8G3rlaNZdRKBKUu7rgceg4GzQotEc3VP?=
 =?us-ascii?Q?ZOv8XYFppl8Nyib0MkMq5krhpyKTsZz5O0nCbrFVtIKIjv4bfonqYsxx1ojF?=
 =?us-ascii?Q?YpHlfOYyLo2Jl3mnLLjheSwymAfphN7V5E93Fzh28wm1hnPQo2lA2RGD0Gat?=
 =?us-ascii?Q?Zq/uf/HA3+1vh55VNYJnK7/i5pfTSzkIcPYU3rPV9Kxp50/qX+flAGm6LdYY?=
 =?us-ascii?Q?bHgG8m5Dii8+H32Eyq2DZ+ePwC/uxqbvc94+7/lzYlGNnNQmbfZps9ZaEkMc?=
 =?us-ascii?Q?34P37b+t7ctyKHQgERTBAjWMALKTO6haRXQt8mctDR0Ngy2ZotngrghdJ+MV?=
 =?us-ascii?Q?3HDTGIyRqXrjkZGtj/FP2SmN0k5jHFSEj2+DqF8axMtK5d+aW7S2i5QLPFfw?=
 =?us-ascii?Q?uanZPf5D/87HPhXPOeu+VDhP/IIbzQ0ISgwBHeTJ4oRHml+gAmfjixy6syZr?=
 =?us-ascii?Q?0YaPs2UhuL4LjRmAzZxeCdn36QwU2aJow6Qi3iHKahUmOuVhTXFENk58hI7o?=
 =?us-ascii?Q?PXfdvfQdnMz74Zn45FuwIEbErSJfWWpaEfhdiBkLampSFUmrs8s+9dh7u4+D?=
 =?us-ascii?Q?9KkzzrUHXPGiPLtUY2PKqZRDBhZj3+oQfJy1t/3WehbtY/brVOfte5x7ErF9?=
 =?us-ascii?Q?RhTPnpwajPew1RuVOhrFLYo0J5U3MX8HVzcroT45qyqRE+8lqcgNyF/a8Ok2?=
 =?us-ascii?Q?dqJ9+6jQBoF9n3sK/QZb1FdZIXrNfrs5uChukF32vA/hN3Yglq48MPPy3JGj?=
 =?us-ascii?Q?ByHl2RnmRy2xjnJyqD1iCxbV31QBPq/hk2Q5uyHR72ktzeTeZnjjnAx8P2Fv?=
 =?us-ascii?Q?IDWT19bgrnTjw+U0Icnhw8f+QUpZuk0voLyFwva76yn4IjDVcxv9E30/YbxT?=
 =?us-ascii?Q?gqlER44Y5+ZJsCkmwlggWHUJmyCaTG9XH/qFy5Tv7osqqfQwqi3T8pEMcUDt?=
 =?us-ascii?Q?Yc1FL3CbieLJjYg/eMceSVEYopGYwkGMnPZ+VIsPx9AdoWQOLy4SbDljV4gz?=
 =?us-ascii?Q?EtNHa3W6taDbqDsNrRglyE0qTi8G0tpI0KYLb6bG98yZ4P/zqFke/zJRzvK6?=
 =?us-ascii?Q?zSart7hV9KaYuI4QjDKI10GE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e190d4ec-a7e6-47b1-4e56-08d8eb3f0a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2021 01:25:25.8105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LsUsBTkn1gef/+Q1kDm5bgJE9YLLx2H7y3vFIyh7p6Hh+1QcUB7flZB/Vn8KM10W30B+dZyVx/lz7YT64iIwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0031
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,
     We have a similar but slightly different requirement.
You change allows a user to force a xprt's remote address to anything, allo=
wing
it to connect to a different address than what it originally had.
The original server/xprt address starts as the one that userspace mount pro=
gram
provides, possibly after resolving the servername used in the mount command=
.

Our requirement is that that server name remains same but its address chang=
es,=20
aka, DNS failover.
Such cases (which I believe are more common) can be handled fully automatic=
ally,
by resolving the server name before every xprt reconnect. CIFS does this.
NFS also has fs/nfs/dns_resolve.c which we can use to do the name resolutio=
n,
though it's currently not being used for this specific use.

Did you have a similar requirement in mind, and/or did you consider the abo=
ve?
Would like to know your thoughts.

Thanks,
Tomar

-----Original Message-----
From: Anna Schumaker <schumakeranna@gmail.com> On Behalf Of schumaker.anna@=
gmail.com
Sent: 13 March 2021 02:48
To: linux-nfs@vger.kernel.org
Cc: Anna.Schumaker@Netapp.com
Subject: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP address

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

It's possible for an NFS server to go down but come back up with a
different IP address. These patches provide a way for administrators to
handle this issue by providing a new IP address for xprt sockets to
connect to.

Chuck has suggested some ideas for future work that could also use this
interface, such as:
- srcaddr: To move between network devices on the client
- type: "tcp", "rdma", "local"
- bound: 0 for autobind, or the result of the most recent rpcbind query
- connected: either true or false
- last: read-only timestamp of the last operation to use the transport
- device: A symlink to the physical network device

Changes in v3:
- Rename functions and objects to make future expansion easier
- Put files under /sys/kernel/sunrpc/client/ instead of
  /sys/kernel/sunrpc/net/, again for future expansions
- Clean up use of WARN_ON_ONCE() in xs_connect()
- Fix up locking, reference counting, and RCU usage
- Unconditionally create files so userspace tools don't need to guess
  what is supported (We return an error message now instead)

Changes in v2:
- Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
- Rename file from "address" to "dstaddr"

Thoughts?
Anna


Anna Schumaker (5):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a client/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects
  sunrpc: Prepare xs_connect() for taking NULL tasks
  sunrpc: Create a per-rpc_clnt file for managing the destination IP
    address

 include/linux/sunrpc/clnt.h |   1 +
 net/sunrpc/Makefile         |   2 +-
 net/sunrpc/clnt.c           |   5 +
 net/sunrpc/sunrpc_syms.c    |   8 ++
 net/sunrpc/sysfs.c          | 191 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  20 ++++
 net/sunrpc/xprtsock.c       |   2 +-
 7 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

--=20
2.29.2


