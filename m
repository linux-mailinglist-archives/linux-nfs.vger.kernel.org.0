Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08492DD181
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 13:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLQMbU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Dec 2020 07:31:20 -0500
Received: from mail-dm6nam12hn2228.outbound.protection.outlook.com ([52.100.166.228]:61760
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgLQMbT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Dec 2020 07:31:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqmskMISnaA9fVImBEnshE74bZIMRqquPkYoC7PWHI2WYnaoLQZuv9EQcEoBxhT53Qi2kK2jTwAJZLbwAByJa9KHR2ZqVxHeGTgBlVT6xeKGV/5r746KzglwDKjFsfLy5y18JDcFhgDBzXpNZociLSopG5+cokow7vf3BruPzLww24Yb7QJphF3a8mgsRUVJug5d8wLCf1INUjvs7iXdFmFSz8cLKnlsT9ADhVijYW6WfnnZZzPZJcgDsd2nlqwfQyg3N2Xspd2eNYcpMI+cCKyPIuTta3PnRXp8vRV0D/SGfWbfPM2hMh7bNvTsI4LtSzauNX0Xx6FUXqe4t8yjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2I/kE8V/mtnLGbO/anBOt8XBVv+4x3cGMKR4TiDiR0=;
 b=Afd7yPvfoy6em7JiGd4r+L+EmU8fmPuERbF8jaXHDiDt75IJNpudyncsv7e3/Q06JX3MJtSCyRuTMyDCC+22/xu4EWuv1XVDma0vxinXOT1AjlX/z2wYXhWJs4G+eGrz0vOyaW2hcwQbsls9T9hZtTlOXvdTrQHjL5Nz7UH8Rlk7cQSeipL1o974aHjA9JlRkGWD9zJdd6jmfjvYtqmQAOKwfGnrnjr1J8NKyuwABGYno7Nc0qysvn87ZgWZG0+6eH7m1NmEIdCDg9AEitaEbLpUxPsQ8V8ve8217Jv07cGV+2jJYq3o1xWe/IkLqu0ALQ0RmdqpQ9urRsJydJk1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tintri.com; dmarc=pass action=none header.from=tintri.com;
 dkim=pass header.d=tintri.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Tintri.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2I/kE8V/mtnLGbO/anBOt8XBVv+4x3cGMKR4TiDiR0=;
 b=YyXKJ/sMuHbQ3WjWEwVp4/+oG5BgiiAgnVyZ6pfmZQNXVX6piGSde2tYbd4kYC2wAhyNXJGGRWDD1Jiq4fTu/O/dYtnFpHBfDo+o+c+rVBX76NOotWaMOrdxXOoFauTzpUS9AeDSsozwZk71NjFtS3zTnjXiWTEuubGPItR1y1U=
Received: from BY5PR11MB4152.namprd11.prod.outlook.com (10.255.163.75) by
 BYAPR11MB2630.namprd11.prod.outlook.com (52.135.225.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.18; Thu, 17 Dec 2020 12:30:31 +0000
Received: from BY5PR11MB4152.namprd11.prod.outlook.com
 ([fe80::f178:f31d:d8cc:445a]) by BY5PR11MB4152.namprd11.prod.outlook.com
 ([fe80::f178:f31d:d8cc:445a%4]) with mapi id 15.20.3654.026; Thu, 17 Dec 2020
 12:30:31 +0000
From:   Suresh Jayaraman <sjayaraman@tintri.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFSv4x share reservations support
Thread-Topic: NFSv4x share reservations support
Thread-Index: AQHW1G4kS09Tsdcl4UGON91elaOZXQ==
Date:   Thu, 17 Dec 2020 12:30:31 +0000
Message-ID: <BY5PR11MB4152DF20ADAAC8F694C80AF1B8C40@BY5PR11MB4152.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=tintri.com;
x-originating-ip: [106.200.226.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 484c2473-be3d-4bbb-52dc-08d8a2878b61
x-ms-traffictypediagnostic: BYAPR11MB2630:
x-microsoft-antispam-prvs: <BYAPR11MB263054B0B4D7F5D0CAB50B3DB8C40@BYAPR11MB2630.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dk01SulSRDQNz6dTNObOKuTnf+T7tpHrIJltRpjTLFYVvdBc9u+p4Ukx0TwlyTj51ERHNoATSBSvULAXiEQdSeP6vQadldrjaRUmXpW0pWTiIZf6eEUlG97UQrZmEDidx5U3aOmrnxpFS221NGXPBz9TPXX6R5yoh7ksMFF2gRZLXlJsvnH+fREypCU5xpAd5cFkWFIEoNRyX4kOyKn3f/UZ0P3PsKMUWbYNey8th99E+xyWeK75GGyc33RyU5jr0P31dWkJIQ9zt4ljqZcE8cVDRBMJuHglU+9Osmpbsvv4TD0Q65S3CpuSSVQWtRRf4Dn/HOxRt7QGgDdGpfx3LjXpn4cUvinut4gCOOoowJyI5lwPFKR6XiBaq6LpyAkQIvC/1GuS5+PRyz6BTcBA4kP/3gANHeqdal4GR6NgmkKFnz6agi+ugR88DyUU3kLcMqjGhJbDeQG3HCennoAqjhcrC5Fctm56co/7w7Uol9aKVWYO/UBp/xlHIyXqoRUv5cEXLiCCzarhIL6xX5TFdsHtfdcnq+L8NiqhxkUk1unuuGFkQ/7No0Bhjwo1iDGnn6uY3VwhlrR5Cb4Ns69sLCI3hivRLpmHlOap5hJS4RmqLjAEl1QxComG6DqnkFjrB7yRWGY3cuF4Rno3VTYnl/JDu5wR5o4lZkuJ+H4HmeSmMFBKFX7eU4WR8SX+kVUMpxKezfc3L2z25SiPx3c9nd1XYQ0vrvjZkD643b8HxyARsBvBUSL7PgZCjvCMkByVnJLgRyTu5rBWBfxPHWsf634UcoY6wQT99MalNIR8T+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR11MB4152.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39850400004)(396003)(136003)(376002)(346002)(366004)(55016002)(52536014)(16799955002)(2906002)(76116006)(9686003)(5660300002)(4744005)(6916009)(316002)(71200400001)(66946007)(66446008)(33656002)(91956017)(966005)(8676002)(66476007)(66556008)(26005)(64756008)(186003)(478600001)(6506007)(8936002)(7696005)(86362001)(56380200001)(32563001);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fZNgTvt7Z8qhsfgKI3LjgzpboX5ZBACHoQykfeWMCsrE+UUXxLV0kEYmqaLH?=
 =?us-ascii?Q?xcV6fpwOznlDrPVv3XW/wfY1KFOca3n4oOj6XcZuouHG6TDlc2TG7vIGol9t?=
 =?us-ascii?Q?MMSnS+I+saTOjYk+hjjKc91Ux5a3yYo1BWyqrX2XT/MSSBEWAhtD02TA5Crg?=
 =?us-ascii?Q?p1+QF4G2FPui+EH9FHL7qGKedjwa5xnGXYRnSnj4scLhJ2VgT3A+G2SV5cyb?=
 =?us-ascii?Q?bfAjE56Sbz9c4kDQmFbyX/H0jlHmk3S/9Rgc8TxsWhbqxFXdPZCUjqD21Y2K?=
 =?us-ascii?Q?socc1vXihBC2clYXVWqpyvcUszphVxjLq80pypviJZ2Ph6VV+E3LJCWr1fQp?=
 =?us-ascii?Q?IFZ/1UpU/FpuwUdszsWqsVCmtQpQXUIE5nWFKeVRMASkQmyXUcVOj6YNVQNa?=
 =?us-ascii?Q?1/4h9lh1kksVA/sQRifl+OrqaWb9jkijmrrqeHy8nH+eI/Cd2gLvayFdkzZY?=
 =?us-ascii?Q?UzusCPUE94R/JZdx3CXj3bF8NNKQENwYraM5JDvHL//TsANo66KD1MZwJpR4?=
 =?us-ascii?Q?/J/kY6UaQ8zM8qVvEL1R4LcwEqi/IneRtdyN4eLhW5+AIWVSE0vuhVhd5AzJ?=
 =?us-ascii?Q?6SV/ETKX8qxcsCGUu4nQPsabAVI+/Ammv9tgIt8MTjpUQOEpZwc+EWIPjny4?=
 =?us-ascii?Q?glu4h90cDZMswyLy2Uqt15/l+1BymDVsb6uZ7bkaRfAGutoAXqfWAaeqee9J?=
 =?us-ascii?Q?XrZhtPMGPM9B55LgOWQvE6sNZp7K6HXSnBpMYQy4sOZ4RsbdhSm5biw81MO0?=
 =?us-ascii?Q?wl/k/vTXzVER97049qmQT2K49E2DA88yxgqL51mymhKjT583Yvd2wTMTGL/e?=
 =?us-ascii?Q?ji0G7x+z+keN+HwMp9+4zgfs2CJUeAjZc5nh/LHtUOAXRp6JZ+OLzEM44U/K?=
 =?us-ascii?Q?EsJU+QsxYr1udh7IkaumRkq3wmJyLc8McBbxkBJgZpagZ9Io7XX1OVO65top?=
 =?us-ascii?Q?TRO+iXjPXwHRwYInkh+wgJZ1RJACUpr/5eSu9ShuKdElBjxcusCIsldp4pMT?=
 =?us-ascii?Q?YoXc973Th6IWRqJxD+ptpzQdpQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Tintri.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4152.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484c2473-be3d-4bbb-52dc-08d8a2878b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 12:30:31.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7aa633be-c8f9-43fe-aff7-41aa956c6e9e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6S4wscZwURGEFNc4nN65Rk/zAfnnR+qWVmBzy1Hu0k7S/P4ZU9T5cMiULD+hns3QW7yleCxYjM6pz/FQtkLDIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2630
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Does Linux NFS server disallow OPENs from SMB or local filesystem when a DE=
NY_READ/DENY_WRITE (share reservation) is set on a file? If so, how is it i=
mplemented (with VFS flags)?

The packet captures show that the Linux NFS4x clients always OPEN with DENY=
_NONE (as there is no POSIX support for DENY_READ/DENY_WRITE). Looked at ht=
tps://linux-nfs.org/wiki/index.php/Cluster_Coherent_NFSv4_and_Share_Reserva=
tions but was not sure if it uptodate.=20

Would like to understand what level of share reservations support is presen=
t in Linux NFS server today.

Thanks,
Suresh
